---
title: Predicting Drug Candidate Promiscuity
author: Tamas Nagy
layout: post
tags: [math]
categories: blog
---
Last month, I gave a presentation to my chemistry seminar class on predicting the promiscuity of small-molecule drug candidates by comparing their structure to the sets of ligands that bind specific proteins. If a drug candidate strongly matches a set of ligands for a certain protein then there is a high probability that it will show off-target effects with that protein. Thus, if a candidate is compared against enough protein-ligand sets then it is likely that we can predict the side-effects of a drug before it enters clinical trials. Using this technique, Keiser et al. were able to identify potential reasons for side effects seen in commonly available drugs [@Keiser2009]. For example, they noticed that Rescriptor, an HIV reverse transcriptase inhibitor, matched the ligand sets of histamine receptors, which could explain the skin rashes observed in patients who were on the drug. They used a variant of the [Jaccard index](http://en.wikipedia.org/wiki/Jaccard_index) known as the Tanimoto coefficient to calculate the similarity between pairs of compounds:

$$ T_c = \frac{\left| \chi_A \cap \chi_B \right|}{\left| \chi_A \cup \chi_B \right|}$$

where $\chi_A$ and $\chi_B$ are sets of features that describe compound $A$ and compound $B$, respectively. My understanding is that they compared the set of ligands for the known target of a drug compound to the all other protein-ligands sets. For each of these set comparisons they computed pairwise $T_c$ values for each ligand in the first set with each ligand in the second set. They then summed all the number of ligand pairs with $T_c > 0.57$ yielding what they termed a *raw score* [@Hert2008]. Now, this raw score is biased by the size of the sets and it does not account for randomness. The authors account for this by transforming the raw scores to Z-scores:

$$ z = \frac{rs(S_1, S_2 - \mu(n(S_1, S_2)}{\sigma(n(S_1, S_2))}$$

where $rs(S_1,S_2)$ is the raw score of set $S_1$ versus. set $S_2$, $n(S_1,S_2)$ is the product of the sizes of the two sets, $\mu$ and $\sigma$ are the expected raw score mean and expected raw score std. dev. Now, they noticed that the background distribution of raw scores for their compound comparisons matched an [extreme value distribution](http://en.wikipedia.org/wiki/Generalized_extreme_value_distribution). Hence, the probability of a same or larger raw score by random chance is given by

$$ P(Z>z) = 1 - exp(-e^{-z\pi/\sqrt{6} - \gamma}) $$

where $\gamma$ is the Euler-Mascheroni constant ($\approx 0.5772156649$). The expectation values can then be found by

$$ E(z) = P(z)N_db  $$

where $N_db$ is the number of set comparisons made while searching the database. Keiser et al. could then compare these expectation values to find novel drug-target interactions across a large set of drugs and a large set of protein-ligand sets.

The full presentation can be found below.

<div class="bigspacer"></div>
<center><iframe src="http://www.slideshare.net/slideshow/embed_code/33171714" width="476" height="400" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe></center>
<div class="bigspacer"></div>

## References

---
csl: /CSLs/plos.csl
references:
- ISSN: 0028-0836
  issue: 7270
  page: 175-181
  title: Predicting new molecular targets for known drugs
  volume: 462
  id: Keiser2009
  issued: {}
  author:
  - given: Michael J.
    family: Keiser
  - given: Vincent
    family: Setola
  - given: John J.
    family: Irwin
  - given: Christian
    family: Laggner
  - given: Atheir I.
    family: Abbas
  - given: Sandra J.
    family: Hufeisen
  - given: Niels H.
    family: Jensen
  - given: Michael B.
    family: Kuijer
  - given: Roberto C.
    family: Matos
  - given: Thuy B.
    family: Tran
  - given: Ryan
    family: Whaley
  - given: Richard A.
    family: Glennon
  - given: Jerome
    family: Hert
  - given: Kelan L. H.
    family: Thomas
  - given: Douglas D.
    family: Edwards
  - given: Brian K.
    family: Shoichet
  - given: Bryan L.
    family: Roth
  container-title: Nature
  publisher: Macmillan Publishers Limited. All rights reserved
  URL: http://dx.doi.org/10.1038/nature08506
  type: article-journal
  DOI: 10.1038/nature08506
- ISSN: 1549-9596
  issue: 4
  page: 755-765
  title: Quantifying the relationships among drug classes
  volume: 48
  id: Hert2008
  issued: {}
  author:
  - given: "Jérôme"
    family: Hert
  - given: Michael J.
    family: Keiser
  - given: John J.
    family: Irwin
  - given: Tudor I.
    family: Oprea
  - given: Brian K.
    family: Shoichet
  container-title: Journal of Chemical Information and Modeling
  publisher: American Chemical Society
  URL: http://dx.doi.org/10.1021/ci8000259
  type: article-journal
  DOI: 10.1021/ci8000259
...
