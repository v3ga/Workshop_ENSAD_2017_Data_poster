# Data poster

**Organisation** // Vadim Bernard — www.depli-ds.com

**Étudiants** // ...

#### Design paramétrique et flux de données
Comment prendre le pouls de la planète ? Quels sont les flux de notre époque accessibles via le réseau qui méritent d’être visualisés graphiquement ? et sous quelles formes ?
Il s’agira de concevoir des affiches animées par des flux données externes, des affiches dont les paramètres visuels (grille, typo, formes, couleurs, contenu, mouvements…) seront directement branchés à ces flux, pour un résultat qui pourra être lisible (didactique) à totalement abstrait.
Nous interrogerons également la matérialité du support (impression, projection, parties motorisées…) en fonction des vitesses de ces flux, et leurs croisements potentiels.

*« Great information visualization never starts from the standpoint of the data set; it starts with questions. Why was the data collected, what’s interesting about it and what stories can it tell ? »* / Ben Fry - Visualizing data

#### Prendre le poul de la planète

Visualiser simplement une donnée variable accessible via internet sous la forme d'une affiche animée. Trouver la bonne forme :
  * thermomètre pour la température.
  * l'horloge pour le temps.
  * mais quoi pour d'autres types de données ? 
  
Intégrer dans le design graphique d'un affiche la variabilité d'un paramètre (typo ou structure paramétriques) : 
* Quelle temporalité pour quelle urgence ? 
* Variables lentes ou rapides ?
* Fonte des glaces / pollution / Cours de la bourse / trends twitter / opinion / sondages / air du temps / mood / fact-checking / activitées numériques diverses …

https://titanpad.com/3nEXCUHlSS

## Méthodologie
### Collecter des données
Télécharger un jeu de données sur son disque dur  ou bien récupérer un flux en « temps réel ».

Exemples : 
* [récupérer en continu des tweets](https://temboo.com/library/Library/Twitter/Search/Tweets/) avec un hashtag particulier.
* [surveiller le flux rss](http://www.lemonde.fr/m-actu/rss_full.xml) du quotidien « Le Monde ».
* [télécharger](https://data.unicef.org/topic/education/overview/) des données sur l'illétrisme sur le site de l'Unicef.    

### Analyser et filtrer
Lire les données depuis un format brut pour les transformer en données manipulables par programme, en ne conservant que les données « intéressantes ».
Voici une liste non exhaustive des formats que l'on pourra rencontrer et manipuler avec [Processing](https://www.processing.org).
* **texte** : une donnée par ligne (fonction [loadStrings](https://processing.org/reference/loadStrings_.html))
* **csv** : fichier « excel » avec des données organisés en lignes et des critères organisés en colonnes (fonction [loadTable](https://processing.org/reference/loadTable_.html))
* **xml**  : organisation arborescente avec notion de parents - enfants (fonction [loadXML](https://processing.org/reference/loadXML_.html))
* **json** : idem avec une notion forte de représentation d'objets (fonction [loadJSONObject](https://processing.org/reference/loadJSONObject_.html))

Il est parfois pratique d'intégrer les éléments lus depuis ces fichiers dans une base de données relationnelles (de [type SQL](https://fr.wikipedia.org/wiki/Structured_Query_Language)) pour disposer d'algorithmes de tri efficaces.

### Déduire
Appliquer des méthodes (mathématiques, statistiques) pour extraire des données significatives en vue de la représentation.

Exemple : 
* utiliser un algorithme de [concordance](https://rednoise.org/rita/tutorial/concordance.php) pour dénombrer le nombre d'occurence de mots dans un texte (qui peut être une agglométation de tweets par exemple)

### Représenter 
Choisir / trouver un mode de représentation des données.
Exemple (non exhaustif) de représentations : 
* [Partition](http://www.generative-gestaltung.de/codes/images/M_5_4_01.png) + 
* [Treemap](https://bl.ocks.org/mbostock/4063582)
* [Force directed graph](https://bl.ocks.org/mbostock/4062045)

## Outils
### Environnement de développement (IDE)
* [Processing](http://www.processing.org)
* [Arduino](http://www.arduino.cc)

### Librairies
* [Rita](https://rednoise.org/rita/) — provides tools for artists and writers working with natural language in programmable media.
* [SQLibrary](https://github.com/fjenett/sql-library-processing) — a SQL database library for Processing
* [Treemap](http://benfry.com/writing/treemap/)
* [Carnivore](http://r-s-g.org/carnivore/) — Surveillance tool for data networks.
* [Text to speech](http://www.frontiernerds.com/text-to-speech-in-processing) (MacOS seuleument)

## Ressources
* [Unité mobile d'expérimentation](http://unitemobile.ensad.fr/?page_id=20)

## Liens
### Données
* [The European Union Open Data Portal](http://data.europa.eu/) is the single point of access to a growing range of data from the institutions and other bodies of the European Union (EU).
* [Data.gov](https://www.data.gov/) (Agriculture, climate, consumer, ecosystems, ...)
* [HealthData.gov](https://www.healthdata.gov) is dedicated to making high value health data more accessible to entrepreneurs, researchers, and policy makers in the hopes of better health outcomes for all.
* [Temboo](https://temboo.com/library/) : accès à des données de services (Amazon, Facebook, Google, Twitter, ...) via leur API (Application programmable interface) 

### Références «Dataviz»
* [Visual Complexity](http://www.visualcomplexity.com/vc/) — mapping patterns of information
* [The book of trees](http://www.bookoftrees.info/bt/) — visualizing branches of knowledge
* [Earth](http://earth.nullschool.net) — a visualization of global weather conditions (jeux de données sur la page [about](https://earth.nullschool.net/about.html))
* [Klarna Data Wall](http://onformative.com/work/klarna-data-wall) — Onformative
* [Phantom terrains](http://phantomterrains.com/) — visualisation d'ondes magnétiques « invisibles »
* [Obamathon](https://medium.com/@itpnyu/itps-obamathon-2e74b1bef9e9#.n2l3jeca1) — projet à l'ITP New-York
* [Fathom](https://fathom.info/projects/) — Fathom Information Design creates products to help people understand data.
* [Stephanie Posavec](http://www.stefanieposavec.co.uk/-everything-in-between/)
* [SoSo Limited - Reconstitution 2008](https://www.sosolimited.com/work/reconstitution-2008/)
