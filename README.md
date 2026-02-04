# EXPLIQUER-OU-PREDIRE-UNE-VARIABLE-QUANTITATIVE-A-PARTIR-DE-PLUSIEURS-FACTEURS
Il s'agit d'un projet réalisé dans le  cadre d’une SAÉ organisée en partenariat avec Open Data University. L'objectif était de comprendre les facteurs qui influencent le nombre de bornes  de recharge installées dans les communes du département du Rhône en Auvergne Rhône Alpes, France.
Cette SAÉ, qui s’est déroulée sur plusieurs semaines, avait pour objectif de relever un défi lié à des problématiques actuelles telles que la diversité en entreprise, le changement climatique ou les véhicules électriques. Le projet s’inscrivait dans une démarche concrète d’analyse et de modélisation de données, avec un fort ancrage professionnel. 
Ce travail m’a permis de comprendre et d’appliquer clairement la distinction essentielle entre analyse exploratoire et modélisation statistique.

# 🔌 Modélisation du nombre de bornes de recharge — Régression linéaire multiple

## 🎯 Objectif du projet
Projet réalisé dans le cadre de la **SAÉ 4.EMS.01 – Expliquer ou prédire une variable quantitative** du BUT Science des Données.  
L’objectif : **modéliser les facteurs expliquant le nombre de bornes de recharge électriques installées dans les communes françaises**, en combinant données techniques, socio‑démographiques et territoriales.

La variable cible est **log_nbre_pdc**, le logarithme du nombre de bornes, afin de stabiliser la variance et améliorer la qualité du modèle.

---

## 🛠️ Compétences mobilisées
- **Data engineering** : fusion de bases via CODGEO, nettoyage, conversions, gestion des formats, transformation logarithmique.
- **Analyse exploratoire** : statistiques descriptives, histogrammes, boxplots, nuages de points, détection d’asymétries et outliers.
- **Modélisation statistique** :  
  - Régression linéaire multiple  
  - Sélection de variables (stepwise AIC)  
  - Interprétation des coefficients  
- **Vérification des hypothèses du modèle** :  
  - Multicolinéarité (VIF)  
  - Autocorrélation (Durbin‑Watson)  
  - Homoscédasticité (Breusch‑Pagan)  
  - Normalité des résidus (Shapiro‑Wilk, QQ‑plot)  
  - Points influents (Cook’s distance)
- **Prédiction** : standardisation, transformation inverse, interprétation opérationnelle.
- **R** : manipulation de données, modélisation, visualisation, diagnostic de modèles.

---

## 📂 Contenu du projet
- **Base fusionnée** : véhicules rechargeables, bornes, puissance installée, revenu médian, population active, superficie.
- **Analyse exploratoire** :  
  - distributions asymétriques  
  - forte hétérogénéité entre communes  
  - identification de valeurs extrêmes
- **Modèle final** (sélection AIC) :  
  - taux_vp_rechargeables  
  - revenu_med_disp  
  - puissance_nominale  
  - superficie  
- **Diagnostics complets** du modèle linéaire.
- **Exemple de prédiction** sur un cas réel.

---

## 📊 Résultats clés
- Le modèle final explique **≈ 61 % de la variance** (R² ajusté = 0,609).  
- Variables significatives :  
  - **taux_vp_rechargeables** (+)  
  - **puissance_nominale** (+)  
  - **revenu_med_disp** (−)  
- La superficie est conservée mais non significative.  
- Légère autocorrélation des résidus (DW ≈ 1,64), mais homoscédasticité et normalité globalement respectées.  
- Deux observations influentes identifiées (indices 9 et 18).  
- Exemple de prédiction : **≈ 179 bornes** pour une commune aux caractéristiques données.

---

## 🧠 Ce que ce projet démontre
- Capacité à **construire un modèle statistique robuste** et à en vérifier toutes les hypothèses.  
- Maîtrise de **R** pour la fusion de données, la modélisation et les diagnostics.  
- Compréhension des enjeux liés à la **transition énergétique** et aux infrastructures de recharge.  
- Rigueur dans l’interprétation des coefficients et la validation des résultats.  
- Aptitude à produire un **rapport clair, structuré et exploitable** pour l’aide à la décision.

---

## 📁 Organisation du dépôt
```
📦 SAE-Regression-Bornes
 ┣ 📄 README.md
 ┣ 📊 data/
 ┃   ┗ fusion_voitures_bornes.csv
 ┣ 📈 visualisations/
 ┃   ┗ *.png
 ┗ 📘 rapport/
     ┗ Rapport_SAE_Muriel_Candice.pdf
```

---

## 🔍 Perspectives
- Intégration de variables spatiales (densité, accessibilité routière).  
- Modèles alternatifs : régression pénalisée, modèles additifs, random forest.  
- Analyse géographique pour cartographier les zones sous‑équipées.
