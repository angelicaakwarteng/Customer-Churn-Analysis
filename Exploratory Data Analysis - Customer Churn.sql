#previewing first five rows
SELECT 
    *
FROM
    project.`customer-churn-dataset`
LIMIT 5;

#checking the number of rows in the dataset
SELECT 
    COUNT(*) AS Total_customers
FROM
    project.`customer-churn-dataset`;

#checking for unique values in the dataset (gender)
SELECT
    DISTINCT gender AS gender_types
FROM
    project.`customer-churn-dataset`;

#checking for unique values in the dataset (Internet Service)
SELECT
    DISTINCT InternetService AS internetservice_types
FROM
    project.`customer-churn-dataset`;

#checking for unique values in the dataset (PaymentMethod)
SELECT
    DISTINCT PaymentMethod AS payment_methods
FROM
    project.`customer-churn-dataset`;

#checking for unique values in the dataset (PaymentMethod)
SELECT
    DISTINCT Contract AS contract_types
FROM
    project.`customer-churn-dataset`;

#check for duplicates in customer ID
SELECT 
    customerID, COUNT(customerID) AS customer_count
FROM
    project.`customer-churn-dataset`
GROUP BY customerID
HAVING COUNT(customerID) > 1;

-- Did churners have dependents
SELECT
    CASE
        WHEN Dependents > 0 THEN 'Has Dependents'
        ELSE 'No Dependents'
    END AS Dependents,
    ROUND(COUNT(customerID) *100 / SUM(COUNT(customerID)), 1) AS Churn_Percentage
FROM
    project.`customer-churn-dataset`
WHERE
    churn = 'Yes'
GROUP BY 
CASE
        WHEN Dependents > 0 THEN 'Has Dependents'
        ELSE 'No Dependents'
    END
ORDER BY Churn_Percentage DESC;

-- Did these churned customers have phone services
SELECT
    PhoneService,
    COUNT(customerID)  AS Churned
FROM
    project.`customer-churn-dataset`
WHERE
    churn = 'Yes'
GROUP BY 
    PhoneService;


-- Did churned customers have tech support?
SELECT 
    TechSupport,
    COUNT(customerID) AS Churned,
    ROUND(COUNT(customerID) *100.0 / SUM(COUNT(customerID)) OVER(), 1) AS Churn_Percentage
FROM
    project.`customer-churn-dataset`
WHERE 
    churn = 'Yes'
GROUP BY TechSupport
ORDER BY Churned DESC;

-- # How much revenue was lost due to churned customers?
SELECT 
	churn,
	COUNT(customerID) AS customer_count,
	(SUM(TotalCharges)) AS Revenue_lost 
FROM project.`customer-churn-dataset`
WHERE churn = 'Yes'
GROUP BY churn;

-- Which service did churned customers use?
SELECT 
    InternetService,
    COUNT(customerID) AS Churned,
    ROUND((COUNT(customerID) * 100.0) / SUM(COUNT(customerID)) OVER(), 1) AS Churn_Percentage
FROM 
    project.`customer-churn-dataset`
WHERE 
    churn = 'Yes'
GROUP BY 
    InternetService
ORDER BY 
    Churned DESC;
    
# What contract were churners on?
SELECT 
    Contract,
    COUNT(customerID) AS Churned,
    ROUND(COUNT(customerID) * 100.0 / SUM(COUNT(customerID)) OVER(), 1) AS Churn_Percentage
FROM 
    project.`customer-churn-dataset`
WHERE
    churn = 'Yes'
GROUP BY
    Contract
ORDER BY 
    Churned DESC;
    
#checking for missing values in each column
SELECT COUNT(*) AS missing_totalcharges FROM project.`customer-churn-dataset` WHERE TotalCharges IS NULL;

#checking for missing values in each column
SELECT COUNT(*) FROM project.`customer-churn-dataset` WHERE SeniorCitizen IS NULL;

#checking for missing values in each column
SELECT COUNT(*) FROM project.`customer-churn-dataset` WHERE Partner IS NULL;

#checking for missing values in each column
SELECT COUNT(*) FROM project.`customer-churn-dataset` WHERE Dependents IS NULL;

#checking for missing values in each column
SELECT COUNT(*) FROM project.`customer-churn-dataset` WHERE tenure IS NULL;

#checking for missing values in each column
SELECT COUNT(*) FROM project.`customer-churn-dataset` WHERE PhoneService IS NULL;

#checking for missing values in each column
SELECT COUNT(*) FROM project.`customer-churn-dataset` WHERE MultipleLines IS NULL;

#checking for missing values in each column
SELECT COUNT(*) FROM project.`customer-churn-dataset` WHERE InternetService IS NULL;

#checking for missing values in each column
SELECT COUNT(*) FROM project.`customer-churn-dataset` WHERE OnlineSecurity IS NULL;

#checking for missing values in each column
SELECT COUNT(*) FROM project.`customer-churn-dataset` WHERE OnlineBackup IS NULL;

#checking for missing values in each column
SELECT COUNT(*) FROM project.`customer-churn-dataset` WHERE DeviceProtection IS NULL;

#checking for missing values in each column
SELECT COUNT(*) FROM project.`customer-churn-dataset` WHERE TechSupport IS NULL;
