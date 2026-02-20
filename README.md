# Spectral Friction Revisited: Quality Factor as the Dominant Governor of Wave Birth Time

**Author:** Amir Reza Babaei  
**Journal:** ASME Journal of Vibration and Acoustics (Under Review)  
**DOI:** [10.5281/zenodo.18612833](https://doi.org/10.5281/zenodo.18612833)  
**GitHub:** [https://github.com/majidstar1234/spectralFriction-Revisited](https://github.com/majidstar1234/spectralFriction-Revisited)

---

## 📌 Overview
This repository contains all MATLAB codes, datasets, figures, and supplementary materials supporting the paper:

> **"Spectral Friction Revisited: Quality Factor as the Dominant Governor of Wave Birth Time"**

The study demonstrates that the spectral friction parameter \(\kappa = T_s/T_0\) in piano strings is predominantly governed by the inverse quality factor \(1/Q\), with a regression model:

\[
\kappa = 0.688 + 8.801\left(\frac{L}{\lambda}\right) - 183.714\left(\frac{1}{Q}\right), \quad R^2 = 0.9994
\]

Sensitivity analysis shows that \(94.7\%\) of the variance in \(\kappa\) originates from \(Q\), confirming its dominant role.

---

## 📁 Repository Structure

| Folder | Description |
|--------|-------------|
| `codes/main_simulation/` | Core MATLAB scripts for the main paper (attack curve, sensitivity, response surface, etc.) |
| `codes/measurement_Q/` | MATLAB codes for practical Q measurement, control, and design guidelines |
| `figures/` | All generated figures (PNG format, 300 dpi) including the graphical abstract |
| `data/` | Experimental data in CSV format (Tables 1 & 2 from the paper) |
| `manuscripts/` | Supplementary manuscript on Q adjustment (PDF) |

---

## 🚀 How to Use

1. **Clone the repository:**
   ```bash
   git clone https://github.com/majidstar1234/spectralFriction-Revisited.git
   cd spectralFriction-Revisited