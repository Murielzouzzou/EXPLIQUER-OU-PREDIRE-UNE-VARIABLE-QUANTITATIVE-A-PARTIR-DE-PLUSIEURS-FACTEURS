# Packages
library(car)
library(lmtest)
library(performance)

# Chargement des données principales
jeu_de_données <- read.csv("fusion_voitures_bornes_densite_residences.csv", header = TRUE, sep = ";")
jeu_de_données$puissance_nominale <- as.numeric(gsub(",", ".", jeu_de_données$puissance_nominale))
jeu_de_données$dens_pop <- as.numeric(gsub(",", ".", jeu_de_données$dens_pop))
jeu_de_données <- na.omit(jeu_de_données)
jeu_de_données$taux_vp_rechargeables <- jeu_de_données$NB_VP_RECHARGEABLES_EL / jeu_de_données$NB_VP

# Chargement du fichier secondaire
jeu_de_données2 <- read.csv2("Fichier_final.csv", encoding = "latin1")
jeu_de_données2$Superficie <- as.numeric(gsub(",", ".", jeu_de_données2$Superficie))
jeu_de_données2$Pop_15_64_ans <- as.numeric(gsub(",", ".", jeu_de_données2$Pop_15_64_ans))

# Fusion des bases
vars_utiles <- jeu_de_données2[, c("CODGEO", "Superficie", "Pop_15_64_ans")]
jeu_fusionne <- merge(jeu_de_données, vars_utiles, by = "CODGEO", all.x = TRUE)

# Transformation log de la cible
jeu_fusionne$log_nbre_pdc <- log(jeu_fusionne$nbre_pdc + 1)

# Standardisation des variables explicatives
vars_exp <- c("taux_vp_rechargeables", "revenu_med_disp", "puissance_nominale", "Pop_15_64_ans", "Superficie")
moyennes <- sapply(jeu_fusionne[, vars_exp], mean, na.rm = TRUE)
ecarts_type <- sapply(jeu_fusionne[, vars_exp], sd, na.rm = TRUE)
jdd <- jeu_fusionne
jdd[, vars_exp] <- scale(jdd[, vars_exp])

# Modèle initial complet
mod_log <- lm(log_nbre_pdc ~ taux_vp_rechargeables + revenu_med_disp + puissance_nominale + Pop_15_64_ans + Superficie, data = jdd)

# Sélection par step AIC
regBest <- step(mod_log, direction = "both")

# Résumé final du modèle choisi
summary(regBest)

# Tests d'application :

# 1. Multicolinéarité (VIF)
vif_vals <- vif(regBest)
print(vif_vals)

# 2. Autocorrélation des résidus (Durbin-Watson)
dw <- dwtest(regBest)
print(dw)

# 3. Hétéroscédasticité (Breusch-Pagan)
bp <- bptest(regBest)
print(bp)

# 4. Normalité des résidus (Shapiro-Wilk)
shapiro <- shapiro.test(residuals(regBest))
print(shapiro)

# 5. Graphiques diagnostics
par(mfrow=c(2,2))
plot(regBest)

# 6. Identification des points influents (distance de Cook)
cooks_d <- cooks.distance(regBest)
cutoff <- 4 / nrow(jdd)
print(paste("Seuil Cook's distance:", cutoff))
outliers <- which(cooks_d > cutoff)
print(paste("Indices des outliers:", paste(outliers, collapse = ", ")))

# Remise en place de par défaut
par(mfrow=c(1,1))

# Prédiction exemple avec standardisation
valeurs_nouvelles <- data.frame(
  taux_vp_rechargeables = 0.15,
  revenu_med_disp = 25740,
  puissance_nominale = 90,
  Pop_15_64_ans = 100000,
  Superficie = 50
)
valeurs_nouvelles_std <- as.data.frame(t((t(valeurs_nouvelles) - moyennes) / ecarts_type))

pred_log <- predict(regBest, newdata = valeurs_nouvelles_std)
nbre_pdc_pred <- exp(pred_log) - 1
print(paste("Prédiction nombre de bornes :", round(nbre_pdc_pred,1)))
