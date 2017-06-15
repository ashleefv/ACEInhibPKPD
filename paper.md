---
title: 'ACEInhibPKPD: An open-source MATLAB app for a pharmacokinetic/pharmacodynamic model of ACE inhibition'
tags:
  - pharmacology
  - biomedical engineering
  - mathematical model
  - MATLAB
authors:
 - name: Ashlee N. Ford Versypt
   orcid: 0000-0001-9059-5703
   affiliation: 1
 - name: Grace K. Harrell
   affiliation: 1
 - name: Alexandra N. McPeak
   affilitation: 1
   
affiliations:
 - name: School of Chemical Engineering, Oklahoma State University
   index: 1
date: 15 June 2017
bibliography: paper.bib
---

# Summary

This software features an MATLAB app install file and the source code for an interactive computer simulation packaged as a MATLAB app that can be used to design the best dosage of pharmaceuticals for reducing high blood pressure. The app uses concepts from chemical engineering and tools from mathematics, pharmacology, and computational science to describe and solve the the dynamics of the chemical reactions in the human body involved in the absorption, metabolism, and excretion of the drug and how the blood pressure-regulating homone angiotensin II is affected by the drug concentration as a function of time. Begin by entering dose size and frequency values and select the ACE inhibitor drug and the patient kidney function from the drop down menus. Run the simulation to generate the plots. Use the plots to analyze the behavior of the tested dosing schedule. Determine what dose size and frequency will be the most effective in lowering the blood pressure by lowering the angiotensin II hormone concentration of the individual to a normal level while managing tradeoffs like efficacy, convenience, price, and side effects. Advanced users may refer to the MATLAB file run_PKPD_without_GUI.m to bypass the GUI to show additional results or edit the code directly. The model used in this software is described in detail in a separate publication [@FordVersypt:2017].

![GUI screenshot](thumbnail.png)

# References
