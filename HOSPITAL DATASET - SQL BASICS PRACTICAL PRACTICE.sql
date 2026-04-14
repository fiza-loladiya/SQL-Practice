-- ============================================
-- HOSPITAL DATASET - SQL BASICS PRACTICAL PRACTICE
-- ============================================

-- TABLES:
-- patients(patient_id, first_name, last_name, gender, date_of_birth, city, state, registration_date)
-- doctors(doctor_id, doctor_name, specialty, department, consultation_fee)
-- appointments(appointment_id, patient_id, doctor_id, appointment_date, appointment_status, diagnosis_cost)
-- payments(payment_id, appointment_id, payment_date, payment_method, payment_status, amount)
-- prescriptions(prescription_id, appointment_id, medicine_name, dosage, days_count)


-- =========================
-- LEVEL 1: SELECT, WHERE, ORDER BY, DISTINCT
-- =========================

-- 1. Show all columns from the patients table.

select * from patients;

-- 2. Show first_name, last_name, city, and state from patients.

select first_name, last_name, city, state from patients;

-- 3. Show all doctors with doctor_name, specialty, and consultation_fee.

select doctor_name, specialty, consultation_fee from doctors;

-- 4. Show all appointments where appointment_status = 'Completed'.

select * from appointments where appointment_status = 'Completed';

-- 5. Show all payments where payment_status = 'Paid'.

select * from payments where payment_status = 'Paid';

-- 6. Show all prescriptions from the prescriptions table.

select * from prescriptions;

-- 7. Show unique cities from patients.

select distinct city from patients;

-- 8. Show unique states from patients.

select distinct state from patients;

-- 9. Show unique specialties from doctors.

select distinct specialty from doctors;

-- 10. Show unique departments from doctors.

select distinct department from doctors;

-- 11. Show unique payment methods from payments.

select distinct payment_method from payments;

-- 12. Show unique appointment statuses from appointments.

select distinct appointment_status from appointments;

-- 13. Show all doctors sorted by consultation_fee in descending order.

select * from doctors order by consultation_fee desc;

-- 14. Show all patients sorted by registration_date from newest to oldest.

select * from patients order by registration_date desc;

-- 15. Show all appointments sorted by appointment_date in ascending order.

select * from appointments order by appointment_date asc;

-- 16. Show top 10 highest consultation_fee doctors.

select * from doctors order by consultation_fee desc limit 10;

-- 17. Show top 5 latest registered patients.

select * from patients order by registration_date desc limit 5;

-- 18. Show all patients from Gujarat.

select * from patients where state = 'Gujarat';

-- 19. Show all patients from Ahmedabad.

select * from patients where city = 'Ahmedabad';

-- 20. Show all doctors from the Cardiology specialty.

select * from doctors where specialty = 'Cardiology';

-- =========================
-- LEVEL 2: FILTERING PRACTICE
-- =========================

-- 21. Show patients whose gender is 'Female'.

select * from patients where gender = 'Female';

-- 22. Show patients whose city is either 'Ahmedabad' or 'Surat'.

select * from patients where city = 'Ahmedabad' or city = 'Surat';

-- 23. Show doctors whose consultation_fee is greater than 1000.

select * from doctors where consultation_fee > 1000;

-- 24. Show doctors whose consultation_fee is between 500 and 1200.

select * from doctors where consultation_fee between 500 and 1200;

-- 25. Show appointments where diagnosis_cost is greater than 2000.

select * from appointments where diagnosis_cost > 2000;

-- 26. Show appointments where diagnosis_cost is between 1000 and 3000.

select * from appointments where diagnosis_cost between 1000 and 3000;

-- 27. Show payments where amount is greater than 1500.

select * from payments where amount > 1500;

-- 28. Show payments where amount is between 500 and 2500.

select * from payments where amount between 500 and 2500;

-- 29. Show prescriptions where days_count is greater than 7.

select * from prescriptions where days_count > 7;

-- 30. Show prescriptions where days_count is 3, 5, or 7.

select * from prescriptions where days_count in (3,5,7);

-- 31. Show appointments where appointment_status is 'Cancelled' or 'No Show'.

select * from appointments where appointment_status = 'Cancelled' or appointment_status = 'No Show';

-- 32. Show payments where payment_status is 'Pending' or 'Refunded'.

select * from payments where payment_status = 'Pending' or payment_status ='Refunded';

-- 33. Show doctors whose department is not 'ICU'.

select * from doctors where department <> 'ICU';

-- 34. Show patients whose state is not 'Gujarat'.

select * from patients where state <> 'Gujarat';

-- 35. Show payments where payment_method is 'UPI'.

select * from payments where payment_method = 'UPI';

-- 36. Show payments where payment_method is in ('Cash', 'Card').

select * from payments where payment_method in ('Cash','Card');

-- 37. Show patients whose first_name starts with 'A'.

select * from patients where first_name like 'A%';

-- 38. Show patients whose last_name ends with 'a'.

select * from patients where last_name like '%a';

-- 39. Show doctors whose doctor_name contains 'Dr.'.

select * from doctors where doctor_name like '%Dr.%';

-- 40. Show medicines whose medicine_name starts with 'P'.

select * from prescriptions where medicine_name like 'P%';

-- =========================
-- LEVEL 3: DATE PRACTICE
-- =========================

-- 41. Show all patients who registered in the year 2025.

select * from patients where year(registration_date) = 2025;

-- 42. Show all appointments that happened in the year 2024.

select * from appointments where year(appointment_date) = 2024;

-- 43. Show all payments made in the year 2025.

select * from payments where year(payment_date) = 2025;

-- 44. Show all patients who registered in January.

select * from patients where monthname(registration_date) = 'January';

-- 45. Show all appointments that happened in December.

select * from appointments where monthname(appointment_date) = 'December';

-- 46. Extract year from registration_date for each patient.

select *, year(registration_date) as reg_year from patients;

-- 47. Extract month from appointment_date for each appointment.

select *, month(appointment_date) as app_month from appointments;

-- 48. Extract day from payment_date for each payment.

select *, day(payment_date) as payment_day from payments;

-- 49. Show patients whose date_of_birth is after '2000-01-01'.

select * from patients where date_of_birth > '2000-01-01';

-- 50. Show appointments between '2025-01-01' and '2025-06-30'.

select * from appointments where appointment_date between '2025-01-01' and '2025-06-30' ;

-- 51. Show payments between '2024-07-01' and '2024-12-31'.

select * from payments where payment_date between '2024-07-01' and '2024-12-31';

-- 52. Show number of days between today and each patient's registration_date.

select *, datediff(curdate(),registration_date) as date_diff from patients ;

-- 53. Show number of days between payment_date and today for each payment.

select *, datediff(curdate(),payment_date) as date_diff from payments;

-- 54. Show all appointments that happened in the current month.

select *
from appointments
where month(appointment_date) = month(curdate())
  and year(appointment_date) = year(curdate());

-- 55. Show all patients registered in the current year.

select *
from patients
where year(registration_date) = year(curdate());

-- 56. Show patient_id and age in years using date_of_birth.

select patient_id,
       timestampdiff(year, date_of_birth, curdate()) as age
from patients;

-- 57. Show appointment month number for every appointment.

select *, month(appointment_date) as appointment_month
from appointments;

-- 58. Show payment year and month for every payment.

select *,
       year(payment_date) as payment_year,
       month(payment_date) as payment_month
from payments;

-- 59. Show all appointments where appointment_date is after '2025-06-01'.

select * from appointments where appointment_date > '2025-06-01';

-- 60. Show all patients who were registered before '2024-01-01'.

select * from patients where registration_date < '2024-01-01';

-- =========================
-- LEVEL 4: AGGREGATE FUNCTIONS
-- =========================

-- 61. Find total number of patients.

select count(*) as total_number_of_patients from patients;

-- 62. Find total number of doctors.

select count(*) as total_number_of_doctors from doctors;

-- 63. Find total number of appointments.

select count(*) as total_number_of_appointments from appointments;

-- 64. Find total number of payments.

select count(*) as total_number_of_payments from payments;

-- 65. Find total number of prescriptions.

select count(*) as total_number_of_prescriptions from prescriptions;

-- 66. Find average consultation_fee of doctors.

select avg(consultation_fee) as avgerage_fee from doctors;

-- 67. Find maximum consultation_fee.

select max(consultation_fee) as max_fee from doctors;

-- 68. Find minimum consultation_fee.

select min(consultation_fee) as min_fee from doctors;

-- 69. Find total diagnosis_cost from appointments.

select sum(diagnosis_cost) as total_diagnosis_cost from appointments;

-- 70. Find average diagnosis_cost from appointments.

select avg(diagnosis_cost) as avg_cost from appointments;

-- 71. Find maximum diagnosis_cost.

select max(diagnosis_cost) as max_cost from appointments;

-- 72. Find minimum diagnosis_cost.

select min(diagnosis_cost) as min_cost from appointments;

-- 73. Find total payment amount from payments.

select sum(amount) as total_payment from payments;

-- 74. Find average payment amount from payments.

select avg(amount) as avg_payment from payments;

-- 75. Find maximum payment amount.

select max(amount) as max_payment from payments;

-- 76. Find minimum payment amount.

select min(amount) as min_payment from payments;

-- 77. Find average days_count from prescriptions.

select avg(days_count) as avg_Days from prescriptions;

-- 78. Find maximum days_count from prescriptions.

select max(days_count) as max_Days from prescriptions;

-- 79. Find minimum days_count from prescriptions.

select min(days_count) as min_Days from prescriptions;

-- 80. Count how many patients are from Gujarat.

select count(*) as total_patient from patients where state  = 'Gujarat';

-- =========================
-- LEVEL 5: GROUP BY + HAVING
-- =========================

-- 81. Count patients by state.

select state, count(*) as total_patient from patients group by state;

-- 82. Count patients by city.

select city, count(*) as total_patient from patients group by city;

-- 83. Count doctors by specialty.

select specialty, count(*) as total_doc from doctors group by specialty;

-- 84. Count doctors by department.

select department, count(*) as total_doc from doctors group by department;

-- 85. Find average consultation_fee by specialty.

select specialty,avg(consultation_fee) as avg_fee from doctors group by specialty;

-- 86. Find average consultation_fee by department.

select department, avg(consultation_fee) as avg_fee from doctors group by department;

-- 87. Count appointments by appointment_status.

select appointment_status, count(*) as total_app from appointments group by appointment_status;

-- 88. Find total diagnosis_cost by appointment_status.

select appointment_status, sum(diagnosis_cost) as total_cost from appointments group by appointment_status;

-- 89. Count payments by payment_method.

select payment_method, count(*) as count_Of_payment from payments group by payment_method;

-- 90. Count payments by payment_status.

select payment_status, count(*) as count_of_payement from payments group by payment_status;

-- 91. Find total payment amount by payment_method.

select payment_method, sum(amount) as total_payment from payments group by payment_method;

-- 92. Find average payment amount by payment_status.

select payment_status, avg(amount) as avg_payment from payments group by payment_status;

-- 93. Count prescriptions by medicine_name.

select medicine_name, count(*) as count_of_pres from prescriptions group by medicine_name;

-- 94. Find average days_count by medicine_name.

select medicine_name, avg(days_count) as avg_days from prescriptions group by medicine_name;

-- 95. Show states having more than 10 patients.

select state, count(*) as more_then_10_patients from patients group by state having count(*) > 10;

-- 96. Show cities having more than 5 patients.

select city, count(*) as more_than_5 from patients group by city having count(*) > 5;

-- 97. Show specialties where average consultation_fee is greater than 1000.

select specialty, avg(consultation_fee) as avg_fee from doctors group by specialty having avg(consultation_fee) > 1000;

-- 98. Show payment methods used more than 50 times.

select  payment_method,count(payment_method) as total from payments group by payment_method having count(payment_method) > 50;

-- 99. Show medicine_name values prescribed more than 20 times.

select medicine_name, count(medicine_name) as total from prescriptions group by medicine_name having count(medicine_name) > 20;

-- 100. Show appointment statuses where total diagnosis_cost is greater than 50000.

select appointment_status, sum(diagnosis_cost) as total_Cost from appointments group by appointment_status
having sum(diagnosis_cost) > 50000;

-- =========================
-- BONUS: CASE WHEN PRACTICE
-- =========================

-- 101. Show doctors and label consultation_fee as 'High Fee' if > 1200 else 'Normal Fee'.

select *,
	   case 
           when consultation_fee > 1200 then 'High Fee'
           else 'Normal Fee'
           end as label
from doctors;

-- 102. Show payments and label amount as 'High', 'Medium', or 'Low'.

select *,
       case
           when amount < 1000 then 'Low'
           when amount between 1000 and 2000 then 'Medium'
           else 'High' end as label
from payments;

-- 103. Show appointments and label status as 'Done' if Completed else 'Not Done'.

select *,
        case 
            when appointment_status = 'Completed' then 'Done'
            else 'Not Done' end as label
from appointments;

-- 104. Show prescriptions and label days_count as 'Short Course' or 'Long Course'.

select *,
	   case 
           when days_count <= 5 then 'Short Course'
           else 'Long Course' end as label
from prescriptions;

-- 105. Show patients and label them as 'Recent' or 'Old' based on registration_date.

select *,
       case
           when registration_date >= curdate() - interval 30 day then 'Recent'
           else 'Old'
       end as label
from patients;