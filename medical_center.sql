DROP DATABASE IF EXISTS medical_center;


CREATE DATABASE medical_center;

\c medical_center;

-- Create doctors table

CREATE TABLE doctors (id SERIAL PRIMARY KEY,
                                        first_name TEXT NOT NULL,
                                                        last_name TEXT NOT NULL);

-- Create patients table

CREATE TABLE patients (id SERIAL PRIMARY KEY,
                                         first_name TEXT NOT NULL,
                                                         last_name TEXT NOT NULL,
                                                                        birth_date DATE NOT NULL);

-- Create diseases table

CREATE TABLE diseases (id SERIAL PRIMARY KEY,
                                         name TEXT NOT NULL,
                                                   description TEXT NOT NULL);

-- Create visits table

CREATE TABLE visits (id SERIAL PRIMARY KEY,
                                       doctor_id INTEGER NOT NULL REFERENCES doctors(id),
                                                                             patient_id INTEGER NOT NULL REFERENCES patients(id),
                                                                                                                    visit_date DATE NOT NULL);

-- Create diagnosis table

CREATE TABLE diagnosis (id SERIAL PRIMARY KEY,
                                          visit_id INTEGER NOT NULL REFERENCES visits(id),
                                                                               disease_id INTEGER NOT NULL REFERENCES diseases(id));

-- Insert doctors

INSERT INTO doctors (first_name, last_name)
VALUES ('John',
        'Doe'), ('Jane',
                 'Smith'), ('Michael',
                            'Johnson');

-- Insert patients

INSERT INTO patients (first_name, last_name, birth_date)
VALUES ('Alice',
        'Brown',
        '1990-05-01'), ('Bob',
                        'Wilson',
                        '1985-10-15'), ('Carol',
                                        'Davis',
                                        '1978-12-03');

-- Insert diseases

INSERT INTO diseases (name, description)
VALUES ('Flu',
        'Influenza is a viral infection that affects the respiratory system.'), ('Migraine',
                                                                                 'A migraine is a type of headache that can cause severe pain, throbbing, and sensitivity to light and sound.'), ('Diabetes',
                                                                                                                                                                                                  'Diabetes is a chronic condition that affects how your body metabolizes glucose.');

-- Insert visits and diagnosis
-- Visit 1: Alice's visit to Dr. Doe, diagnosed with Flu
 
INSERT INTO visits (doctor_id, patient_id, visit_date)
VALUES (1, 
        1, 
        '2023-05-01');


INSERT INTO diagnosis (visit_id, disease_id)
VALUES (1,
        1);

-- Visit 2: Bob's visit to Dr. Smith, diagnosed with Migraine and Diabetes
 
INSERT INTO visits (doctor_id, patient_id, visit_date)
VALUES (2, 
        2, 
        '2023-04-20');


INSERT INTO diagnosis (visit_id, disease_id)
VALUES (2,
        2), (2,
             3);

-- Visit 3: Carol's visit to Dr. Johnson, diagnosed with Flu and Diabetes
 
INSERT INTO visits (doctor_id, patient_id, visit_date)
VALUES (3, 
        3, 
        '2023-03-15');


INSERT INTO diagnosis (visit_id, disease_id)
VALUES (3,
        1), (3,
             3);

-- Sample queries
-- 1. Retrieve all doctors

SELECT *
FROM doctors;

-- 2. Retrieve all patients

SELECT *
FROM patients;

-- 3. Retrieve all diseases

SELECT *
FROM diseases;

-- 4. Retrieve all visits with doctor and patient information

SELECT v.id,
       v.visit_date,
       d.first_name AS doctor_first_name,
       d.last_name AS doctor_last_name,
       p.first_name AS patient_first_name,
       p.last_name AS patient_last_name,
       p.birth_date AS patient_birth_date
FROM visits v
JOIN doctors d ON v.doctor_id = d.id
JOIN patients p ON v.patient_id = p.id;

-- 5. Retrieve all diagnoses with visit, doctor, patient, and disease information

SELECT d.id,
       v.visit_date,
       doc.first_name AS doctor_first_name,
       doc.last_name AS doctor_last_name,
       p.first_name AS patient_first_name,
       p.last_name AS patient_last_name,
       p.birth_date AS patient_birth_date,
       ds.name AS disease_name,
       ds.description AS disease_description
FROM diagnosis d
JOIN visits v ON d.visit_id = v.id
JOIN diseases ds ON d.disease_id = ds.id
JOIN doctors doc ON v.doctor_id = doc.id
JOIN patients p ON v.patient_id = p.id;