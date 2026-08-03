create database phonepe;
drop database phonepe;
use phonepe;

select registration_date,state, monthly_income from phonepe where state="Bihar";
# 🚀 PHONEPE BUSINESS ANALYTICS SQL CHALLENGE

# -----------------------------
# LEVEL 1 – CUSTOMER INTELLIGENCE
# -----------------------------

# 1. The CEO wants the Top 10 customers contributing 40% of total revenue. Find them.
select first_name,sum(total_amount) from phonepe where first_name like "Am%" group by first_name ;
select first_name,round(sum(total_amount),2) as "Transaction" from phonepe group by first_name order by Transaction desc limit 10;
# 2. Find users whose wallet balance is above the average of their city but below the average of their state.
select avg(wallet_balance), avg(wallet_balance) as "city_wallet_balance" from phonepe;
# 3. Find users who registered in the same month as the richest customer but belong to a different city.
select distinct(city),first_name,registration_date,wallet_balance from phonepe where month(registration_date)=10 order by wallet_balance desc;

# 4. Display the Top 3 cities where:
#    - Verified users >80%
select city,count(*) as "count" from phonepe where kyc_status="Verified" group by city order by count desc;
#    - Average wallet > ₹25,000
#    - Average credit score >700

# 5. Find users whose transaction amount is greater than the average of their occupation but less than the maximum of their state.

# -----------------------------
# LEVEL 2 – REVENUE ANALYTICS
# -----------------------------

# 6. Find the city contributing the highest revenue in every state.

# 7. Find the occupation contributing the highest wallet balance in every bank.
select * from phonepe;
select avg(monthly_income) from phonepe where occupation="Student";
select avg(monthly_income) from phonepe where occupation="Engineer";
select avg(monthly_income) from phonepe where state="Bihar";
select avg(monthly_income) from phonepe where state="Odisha";
select occupation,round(sum(wallet_balance),2) as "total" from phonepe group by occupation order by total desc;
# 8. Calculate every city's percentage contribution to total revenue.
select city,(sum(total_amount))*(100/sum(total_amount)) from phonepe group by city;
select city,sum(total_amount) from phonepe group by city;
# 9. Find cities contributing less than 2% of revenue but having more than 500 active users.

# 10. Find the bank whose premium customers generate maximum revenue.
#Find the busiest transaction day.
select  day(last_login),max(avg_transaction) as "maxx" from phonepe group by day(last_login) order by maxx desc;
#Find the payment mode with the highest success rate.
select payment_method,sum(total_amount) as "aaa" from phonepe group by payment_method order by aaa desc;
#Identify inactive users.
select * from phonepe;
select count(*) from phonepe where is_active="No";
#Find users with the highest number of transactions.
select first_name ,total_transactions,state,city from phonepe order by total_transactions desc;
#Find repeat users.
#Find merchants with the highest failures.
#Find users making unusually large transactions.
#Calculate customer retention.
# -----------------------------
# LEVEL 3 – FRAUD DETECTION
# -----------------------------

# 11. Find users with:
#     - Pending KYC
select COUNT(*) from phonepe where kyc_status="Pending";
select COUNT(*) from phonepe where kyc_status="Verified";
select COUNT(*) from phonepe where is_active="Yes";
select COUNT(*) from phonepe where is_active="No";
#     - Wallet Balance > ₹50,000
select first_name, last_name,wallet_balance from phonepe where wallet_balance>49000;
#     - Wallet Balance ₹30000 to ₹50,000
select first_name, last_name,wallet_balance from phonepe where wallet_balance between 30000 and 40000;

# 12. Find duplicate mobile numbers registered in different cities.

# 13. Find duplicate email IDs having different customer names.

# 14. Find users logging in after one year of registration.
select first_name ,year(last_login),year(registration_date) from phonepe where year(last_login)=year(registration_date)+1;
# 15. Find suspicious users making unusually high transactions compared to other users in the same city.

select count(*) from phonepe;
# -----------------------------
# LEVEL 4 – GROWTH ANALYTICS
# -----------------------------

# 16. Rank every month based on registrations.

# 17. Calculate Month-over-Month (MoM) registration growth.

# 18. Find states where registrations decreased for three consecutive months.

# 19. Find cities with the highest Year-over-Year (YoY) growth.
# 20. Find the fastest-growing occupations.
select occupation,sum(monthly_income) as "growing" from phonepe group by occupation order by growing desc;
# -----------------------------
# LEVEL 5 – PRODUCT ANALYTICS
# -----------------------------

# 21. Which payment method generates the highest average transaction amount?

# 22. Rank payment methods within every city.

# 23. Calculate Android vs iOS revenue contribution.

# 24. Find cities where Android users spend more than iOS users.

# 25. Find users who updated to the latest app version most recently.

# -----------------------------
# LEVEL 6 – CUSTOMER SEGMENTATION
# -----------------------------

# 26. Categorize users into Platinum, Gold, Silver, and Bronze using:
#     - Monthly Income
select first_name,last_name,monthly_income from phonepe order by monthly_income desc limit 4;
#     - Wallet Balance
select first_name,last_name,wallet_balance from phonepe order by wallet_balance desc limit 4;
#     - Credit Score
select first_name,last_name,credit_score from phonepe order by credit_score desc limit 4;
#     - Total Transactions
select first_name,sum(total_transactions) from phonepe group by first_name;
# 27. Find the percentage of Platinum users in every city.

# 28. Find average income for every customer segment.

# 29. Find top-performing cities for each customer segment.

# 30. Calculate revenue contribution of every customer segment.

# -----------------------------
# LEVEL 7 – WINDOW FUNCTIONS
# -----------------------------

# 31. Find the second richest customer from every city.
select first_name ,city, row_number() over(partition by(city) order by monthly_income) from phonepe ;
WITH cte AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY city ORDER BY monthly_income DESC ) AS rn FROM phonepe) SELECT *FROM cte WHERE rn = 1;
# 32. Find the third highest transaction amount in every occupation.
select * , row_number() over(partition by occupation order by total_amount desc) from phonepe;
# 33. Find the first registered customer from every state.
select *,row_number() over(partition by state order by registration_date) from phonepe;
# 34. Calculate running revenue ordered by registration date.

# 35. Calculate the moving average of wallet balance for the last five registered users.

# -----------------------------
# LEVEL 8 – BUSINESS DECISION MAKING
# -----------------------------

# 36. If PhonePe wants to launch a cashback campaign, which five cities should be targeted? Justify using SQL output.
select city , sum(total_amount) as "Max" from phonepe group by city order by Max desc;
# 37. Which occupation should receive loan offers?
select occupation,avg(credit_score) from phonepe group by occupation order by occupation desc limit 1;
# 38. Which users should receive insurance recommendations?

# 39. Which inactive users should receive re-engagement notifications?

# 40. Which banks should PhonePe partner with for maximum business impact?
select bank_name,round(sum(total_amount),2) as "tota" from phonepe group by bank_name order by tota desc limit 1;
select * from phonepe ;
# -----------------------------
# LEVEL 9 – EXECUTIVE DASHBOARDS
# -----------------------------

# 41. Build a CEO Dashboard showing:
#     - Total Users
#     - Active Users
#     - Total Revenue
#     - Total Wallet Balance
#     - Average Credit Score
#     - Average Income
#     - Verified User %
#     - Premium User %

# 42. Build a Marketing Dashboard.

# 43. Build a Finance Dashboard.

# 44. Build an Operations Dashboard.

# 45. Build a Product Analytics Dashboard.

# -----------------------------
# LEVEL 10 – REAL BUSINESS CASE STUDIES
# -----------------------------

# 46. Revenue dropped by 12%.
#     Write SQL queries to identify the root cause.

# 47. Transactions increased but revenue decreased.
#     Perform SQL analysis and explain possible reasons.

# 48. Registrations doubled but active users remained unchanged.
#     Identify the problem using SQL.

# 49. Wallet balances increased but transaction volume decreased.
#     Which KPIs and SQL queries would you analyze first?

# 50. The CEO asks:
#     "If I invest ₹5 crore in only one state, where should I invest?"
#     Perform SQL analysis and provide a business recommendation.

# -----------------------------
# BONUS – ADVANCED PRODUCT ANALYTICS
# -----------------------------

# 51. Perform RFM (Recency, Frequency, Monetary) analysis.

# 52. Identify customers likely to churn.

# 53. Perform cohort analysis by registration month.

# 54. Calculate customer retention for Day-1, Day-7, and Day-30.

# 55. Identify the top 20% of customers contributing to 80% of revenue (Pareto Analysis).

# 56. Detect fraudulent users based on abnormal transaction patterns.

# 57. Calculate median transaction amount for each city.

# 58. Find the top 5 merchants (or merchant categories) by revenue.

# 59. Build a monthly executive KPI report with growth percentages.

# 60. Create a complete business summary report for management with insights and recommendations.




