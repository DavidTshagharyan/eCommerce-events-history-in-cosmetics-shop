# E-commerce Conversion Optimization

## 🎯 Business Problem
Online store visitors don't all convert into buyers. This project analyzes 
user behavior to answer:
- Why do some customers purchase while others don't?
- Which page/stage has the highest drop-off?
- Would a UI change (e.g. button color) improve sales?
- Which customers are most likely to buy?

## 📊 Dataset
[eCommerce Events History in Cosmetics Shop - Kaggle](https://www.kaggle.com/datasets/mkechinov/ecommerce-events-history-in-cosmetics-shop)

5 months of clickstream data (Oct 2019 – Feb 2020) from a mid-size cosmetics 
online store — ~20.7M raw events (`view`, `cart`, `remove_from_cart`, `purchase`).

## 🛠 Tech Stack
- **Database:** PostgreSQL
- **Languages:** Python, SQL
- **Libraries:** Pandas, NumPy, Scikit-learn, Matplotlib, Seaborn, SQLAlchemy, Statsmodels
- **Tools:** DBeaver, VS Code, Jupyter, Git/GitHub

## 📁 Project Structure

```
ecommerce-conversion-optimization/
│
├── data/
│   ├── raw/                          # original CSV files (not tracked in git)
│   └── processed/                    # cleaned & aggregated data (not tracked in git)
├── sql/
│   ├── schema.sql
│   └── queries/
│       ├── 01_data_cleaning.sql
│       ├── 02_diagnostics.sql
│       └── 03_feature_engineering.sql
├── notebooks/
│   ├── 01_python_setup_and_load.ipynb
│   ├── 02_eda_funnel.ipynb
│   ├── 03_segmentation.ipynb
│   ├── 04_category_analysis.ipynb
│   ├── 05_ml_modeling.ipynb
│   └── 06_ab_testing.ipynb
├── src/
│   └── purchase_prediction_model.pkl
├── visuals/                          # exported charts (PNG)
└── requirements.txt
```

## 🔍 Key Findings

### 1. Conversion Funnel
Overall conversion rate is **3.4%**. The biggest drop-off happens at the 
**Cart → Purchase** stage (**84.3%** loss), not View → Cart (77.1%). This 
means checkout/payment experience is the single biggest optimization 
opportunity.

### 2. Cart Abandonment
**72.4%** of customers who add a product to cart **never complete a purchase** 
over the entire 5-month period. However, **46.2%** of this group returns to 
the site at least once more — suggesting email/push retargeting could 
recover a meaningful share of lost revenue.

### 3. Customer Segmentation
RFM analysis identified a **"Champions"** segment (18.2% of customers) with 
a **21.4%** buyer rate — 3x the dataset average. K-Means clustering went 
further, isolating a **0.3% "VIP"** micro-segment with a **93.5%** buyer 
rate and $270 average spend, hidden inside the broader Champions group.

### 4. Product Discovery Drives Purchases
Customers who convert explore **3–6x more** products and categories than 
those who don't. The ML model confirms this: **unique_categories_viewed** 
is the strongest single predictor of purchase (26.7% feature importance) — 
stronger than raw page-view count.

### 5. Predictive Model
A **Random Forest** model predicts session-level purchase probability with 
**97.2% ROC-AUC** and **98% recall**, meaning it correctly flags almost all 
sessions that end in a purchase.

### 6. A/B Testing Framework
A full A/B testing methodology was demonstrated (power analysis → sample 
size → significance testing) on a simulated button-color experiment, 
detecting a **15%** relative lift as statistically significant (**p < 0.001**).

> Note: the A/B test uses simulated outcomes on real session data to 
> demonstrate methodology — the underlying dataset has no real experiment.

## 💡 Business Recommendations

| # | Finding | Recommendation |
|---|---|---|
| 1 | 84.3% drop-off at Cart→Purchase | Audit and simplify the checkout flow (guest checkout, fewer form fields, visible shipping cost earlier) |
| 2 | 72.4% cart abandonment, 46.2% return | Launch an automated cart-abandonment email/push campaign targeting returning visitors |
| 3 | 0.3% VIP segment drives disproportionate revenue | Build a dedicated loyalty/VIP program (early access, personal offers) |
| 4 | Category breadth predicts conversion | Invest in cross-category recommendations ("customers also viewed") to widen exploration |
| 5 | Model flags high-intent sessions in real time | Use the model to trigger real-time incentives (discount popup, live chat) for high-probability, not-yet-converted sessions |
| 6 | A/B test showed significant lift potential | Adopt a formal A/B testing process for future UI changes, using the power-analysis approach shown here |

## 📈 Results Summary

| Metric | Value |
|---|---|
| Events analyzed | 19.5M (post-cleaning) |
| Unique users | 1.64M |
| Unique sessions | 4.48M |
| Overall conversion rate | 3.39% |
| Cart abandonment rate | 72.4% |
| Best ML model | Random Forest |
| ROC-AUC | 0.972 |
| Recall (purchase class) | 0.98 |
| Top predictive feature | unique_categories_viewed |
| A/B test significance | p < 0.001 |

## 🚀 How to Run
1. Clone the repo and download the sdataset from Kaggle into `data/raw/`
2. `pip install -r requirements.txt`
3. Load data into PostgreSQL: `psql -U postgres -d ecommerce_cosmetics -f sql/schema.sql`
4. Run `sql/queries/` scripts in order (01 → 03)
5. Run notebooks in order (01 → 06)
