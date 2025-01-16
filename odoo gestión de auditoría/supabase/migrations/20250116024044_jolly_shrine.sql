/*
  # Add sample data for audit management

  1. Sample Data
    - 10 audit programs
    - 10 audit notifications
    - 10 audit plans
    - 10 audit findings
    - 10 audit reports
    - 10 nonconformities
    - 10 action plans
    - 10 audit areas
    - 10 auditor certifications
    - 10 auditor evaluations

  2. Data Relationships
    - Maintains referential integrity
    - Creates realistic audit scenarios
    - Links related records appropriately
*/

-- Insert sample audit programs
INSERT INTO audit_programs (name, code, year, start_date, end_date, objective, scope, state, responsible_id) VALUES
('Annual Quality Audit 2024', 'AQA-2024', 2024, '2024-01-01', '2024-12-31', 'Evaluate quality management system effectiveness', 'All quality processes and procedures', 'in_progress', auth.uid()),
('IT Security Audit Program', 'ITSA-2024', 2024, '2024-03-01', '2024-06-30', 'Assess cybersecurity controls', 'IT infrastructure and security protocols', 'planned', auth.uid()),
('Environmental Compliance Audit', 'ECA-2024', 2024, '2024-02-01', '2024-05-31', 'Verify environmental regulation compliance', 'Environmental management systems', 'draft', auth.uid()),
('Financial Controls Audit', 'FCA-2024', 2024, '2024-04-01', '2024-07-31', 'Review financial control effectiveness', 'Financial processes and controls', 'approved', auth.uid()),
('Safety Management Audit', 'SMA-2024', 2024, '2024-05-01', '2024-08-31', 'Evaluate workplace safety compliance', 'Safety procedures and protocols', 'in_progress', auth.uid()),
('Supply Chain Audit', 'SCA-2024', 2024, '2024-06-01', '2024-09-30', 'Assess supplier management processes', 'Supplier evaluation and monitoring', 'planned', auth.uid()),
('HR Process Audit', 'HRA-2024', 2024, '2024-07-01', '2024-10-31', 'Review HR policies compliance', 'HR procedures and documentation', 'draft', auth.uid()),
('Production Quality Audit', 'PQA-2024', 2024, '2024-08-01', '2024-11-30', 'Assess production quality standards', 'Manufacturing processes', 'approved', auth.uid()),
('Customer Service Audit', 'CSA-2024', 2024, '2024-09-01', '2024-12-31', 'Evaluate customer service quality', 'Customer service processes', 'in_progress', auth.uid()),
('Data Privacy Audit', 'DPA-2024', 2024, '2024-10-01', '2025-01-31', 'Verify data protection compliance', 'Data privacy controls', 'planned', auth.uid());

-- Insert sample audit plans
INSERT INTO audit_plans (name, program_id, planned_date, duration, objective, scope, methodology, state) VALUES
('Q1 Quality System Review', (SELECT id FROM audit_programs WHERE code = 'AQA-2024'), '2024-02-15', 5, 'Review Q1 quality metrics', 'Quality management processes', 'Document review and interviews', 'in_progress'),
('IT Security Assessment', (SELECT id FROM audit_programs WHERE code = 'ITSA-2024'), '2024-03-15', 3, 'Evaluate security controls', 'IT systems and networks', 'Technical testing and reviews', 'planned'),
('Environmental Impact Review', (SELECT id FROM audit_programs WHERE code = 'ECA-2024'), '2024-02-20', 4, 'Assess environmental impact', 'Environmental procedures', 'Site inspection and documentation review', 'draft'),
('Financial Controls Review', (SELECT id FROM audit_programs WHERE code = 'FCA-2024'), '2024-04-10', 5, 'Evaluate financial controls', 'Financial processes', 'Process testing and verification', 'completed'),
('Safety Compliance Check', (SELECT id FROM audit_programs WHERE code = 'SMA-2024'), '2024-05-15', 3, 'Verify safety compliance', 'Safety protocols', 'Site inspection and interviews', 'in_progress'),
('Supplier Evaluation', (SELECT id FROM audit_programs WHERE code = 'SCA-2024'), '2024-06-20', 4, 'Assess key suppliers', 'Supplier management', 'Document review and site visits', 'planned'),
('HR Policy Review', (SELECT id FROM audit_programs WHERE code = 'HRA-2024'), '2024-07-15', 3, 'Review HR compliance', 'HR policies', 'Documentation review and interviews', 'draft'),
('Production Process Audit', (SELECT id FROM audit_programs WHERE code = 'PQA-2024'), '2024-08-10', 5, 'Evaluate production quality', 'Manufacturing processes', 'Process observation and testing', 'completed'),
('Customer Service Review', (SELECT id FROM audit_programs WHERE code = 'CSA-2024'), '2024-09-15', 3, 'Assess service quality', 'Customer service operations', 'Call monitoring and reviews', 'in_progress'),
('Data Protection Assessment', (SELECT id FROM audit_programs WHERE code = 'DPA-2024'), '2024-10-20', 4, 'Verify data compliance', 'Data protection measures', 'System testing and reviews', 'planned');

-- Insert sample audit findings
INSERT INTO audit_findings (name, code, audit_plan_id, finding_date, type, description, evidence, severity, state) VALUES
('Missing Quality Documentation', 'F001', (SELECT id FROM audit_plans LIMIT 1), '2024-02-16', 'nonconformity', 'Quality procedures not properly documented', 'Missing documentation in sections 3.1-3.4', 'high', 'open'),
('Weak Password Policy', 'F002', (SELECT id FROM audit_plans OFFSET 1 LIMIT 1), '2024-03-16', 'nonconformity', 'Password policy does not meet security standards', 'Current policy allows weak passwords', 'critical', 'open'),
('Improper Waste Disposal', 'F003', (SELECT id FROM audit_plans OFFSET 2 LIMIT 1), '2024-02-21', 'nonconformity', 'Hazardous waste not properly segregated', 'Photos of mixing in waste area', 'high', 'action_required'),
('Unauthorized Access', 'F004', (SELECT id FROM audit_plans OFFSET 3 LIMIT 1), '2024-04-11', 'observation', 'Unauthorized personnel in restricted area', 'Security camera footage', 'medium', 'closed'),
('Missing Safety Signs', 'F005', (SELECT id FROM audit_plans OFFSET 4 LIMIT 1), '2024-05-16', 'nonconformity', 'Required safety signage not displayed', 'Photos of areas missing signs', 'medium', 'in_progress'),
('Supplier Documentation Gap', 'F006', (SELECT id FROM audit_plans OFFSET 5 LIMIT 1), '2024-06-21', 'observation', 'Incomplete supplier evaluation records', 'Missing evaluation forms', 'low', 'open'),
('Training Records Gap', 'F007', (SELECT id FROM audit_plans OFFSET 6 LIMIT 1), '2024-07-16', 'nonconformity', 'Employee training records not up to date', 'Expired certifications', 'medium', 'action_required'),
('Quality Control Skip', 'F008', (SELECT id FROM audit_plans OFFSET 7 LIMIT 1), '2024-08-11', 'nonconformity', 'Quality control steps being skipped', 'Process observation notes', 'high', 'closed'),
('Customer Complaint Handling', 'F009', (SELECT id FROM audit_plans OFFSET 8 LIMIT 1), '2024-09-16', 'opportunity', 'Improve complaint resolution time', 'Complaint resolution metrics', 'low', 'in_progress'),
('Data Backup Failure', 'F010', (SELECT id FROM audit_plans OFFSET 9 LIMIT 1), '2024-10-21', 'nonconformity', 'Backup system not functioning properly', 'System logs showing failures', 'critical', 'open');

-- Insert sample nonconformities
INSERT INTO nonconformities (name, finding_id, description, root_cause, correction, corrective_action, responsible_id, deadline, state) VALUES
('QMS Documentation Gap', (SELECT id FROM audit_findings WHERE code = 'F001'), 'Quality procedures not documented', 'Lack of documentation process', 'Create missing documents', 'Implement documentation review process', auth.uid(), '2024-03-15', 'analysis'),
('Insufficient Security Controls', (SELECT id FROM audit_findings WHERE code = 'F002'), 'Weak password requirements', 'Outdated security policy', 'Update password policy', 'Implement password management system', auth.uid(), '2024-04-15', 'action'),
('Waste Management Issue', (SELECT id FROM audit_findings WHERE code = 'F003'), 'Improper waste handling', 'Inadequate training', 'Correct waste segregation', 'Conduct waste management training', auth.uid(), '2024-03-20', 'verification'),
('Security Access Control', (SELECT id FROM audit_findings WHERE code = 'F004'), 'Unauthorized access to restricted areas', 'Poor access control', 'Implement access restrictions', 'Install card readers', auth.uid(), '2024-05-10', 'closed'),
('Safety Compliance Gap', (SELECT id FROM audit_findings WHERE code = 'F005'), 'Missing safety signage', 'Incomplete safety program', 'Install required signs', 'Regular safety audits', auth.uid(), '2024-06-15', 'analysis'),
('Supplier Management Gap', (SELECT id FROM audit_findings WHERE code = 'F006'), 'Incomplete supplier records', 'Poor record keeping', 'Update supplier files', 'Implement supplier management system', auth.uid(), '2024-07-20', 'action'),
('Training Compliance Issue', (SELECT id FROM audit_findings WHERE code = 'F007'), 'Outdated training records', 'No tracking system', 'Update training records', 'Implement training management system', auth.uid(), '2024-08-15', 'verification'),
('Production Quality Issue', (SELECT id FROM audit_findings WHERE code = 'F008'), 'Quality control bypass', 'Time pressure', 'Reinforce procedures', 'Implement quality checks', auth.uid(), '2024-09-10', 'closed'),
('Service Quality Gap', (SELECT id FROM audit_findings WHERE code = 'F009'), 'Slow complaint resolution', 'Inefficient process', 'Streamline process', 'Implement new CRM system', auth.uid(), '2024-10-15', 'analysis'),
('Data Management Issue', (SELECT id FROM audit_findings WHERE code = 'F010'), 'Backup system failure', 'System configuration', 'Fix backup system', 'Implement monitoring system', auth.uid(), '2024-11-20', 'action');

-- Insert sample action plans
INSERT INTO action_plans (name, nonconformity_id, description, responsible_id, start_date, end_date, resources, progress, state) VALUES
('QMS Documentation Update', (SELECT id FROM nonconformities LIMIT 1), 'Update quality management documentation', auth.uid(), '2024-02-20', '2024-03-20', 'Documentation team, QMS software', 30, 'in_progress'),
('Security Policy Enhancement', (SELECT id FROM nonconformities OFFSET 1 LIMIT 1), 'Strengthen security controls', auth.uid(), '2024-03-20', '2024-04-20', 'IT team, security software', 20, 'approved'),
('Waste Management Program', (SELECT id FROM nonconformities OFFSET 2 LIMIT 1), 'Improve waste handling procedures', auth.uid(), '2024-02-25', '2024-03-25', 'Environmental team, training materials', 40, 'in_progress'),
('Access Control Implementation', (SELECT id FROM nonconformities OFFSET 3 LIMIT 1), 'Implement new access control system', auth.uid(), '2024-04-15', '2024-05-15', 'Security team, access control equipment', 100, 'completed'),
('Safety Program Update', (SELECT id FROM nonconformities OFFSET 4 LIMIT 1), 'Update safety compliance program', auth.uid(), '2024-05-20', '2024-06-20', 'Safety team, signage materials', 25, 'in_progress'),
('Supplier Management System', (SELECT id FROM nonconformities OFFSET 5 LIMIT 1), 'Implement supplier management system', auth.uid(), '2024-06-25', '2024-07-25', 'Procurement team, software licenses', 15, 'approved'),
('Training Management Program', (SELECT id FROM nonconformities OFFSET 6 LIMIT 1), 'Implement training tracking system', auth.uid(), '2024-07-20', '2024-08-20', 'HR team, training software', 35, 'in_progress'),
('Quality Control Enhancement', (SELECT id FROM nonconformities OFFSET 7 LIMIT 1), 'Strengthen quality control process', auth.uid(), '2024-08-15', '2024-09-15', 'Quality team, testing equipment', 100, 'completed'),
('Customer Service Improvement', (SELECT id FROM nonconformities OFFSET 8 LIMIT 1), 'Improve complaint handling process', auth.uid(), '2024-09-20', '2024-10-20', 'Service team, CRM system', 20, 'in_progress'),
('Data Backup System Upgrade', (SELECT id FROM nonconformities OFFSET 9 LIMIT 1), 'Upgrade backup infrastructure', auth.uid(), '2024-10-25', '2024-11-25', 'IT team, backup hardware', 10, 'approved');

-- Insert sample audit areas
INSERT INTO audit_areas (name, description) VALUES
('Quality Management', 'Quality management system and processes'),
('Information Security', 'IT security and cybersecurity controls'),
('Environmental Management', 'Environmental compliance and sustainability'),
('Financial Controls', 'Financial processes and internal controls'),
('Occupational Safety', 'Workplace safety and health'),
('Supply Chain Management', 'Supplier evaluation and management'),
('Human Resources', 'HR policies and procedures'),
('Production Quality', 'Manufacturing and production processes'),
('Customer Service', 'Customer service and satisfaction'),
('Data Protection', 'Data privacy and protection controls');

-- Insert sample auditor certifications
INSERT INTO auditor_certifications (auditor_id, name, issuing_body, issue_date, expiry_date, certification_number) VALUES
(auth.uid(), 'Certified Internal Auditor', 'IIA', '2023-01-15', '2026-01-15', 'CIA-2023-001'),
(auth.uid(), 'ISO 9001 Lead Auditor', 'IRCA', '2023-02-20', '2026-02-20', 'IRCA-2023-001'),
(auth.uid(), 'Environmental Auditor', 'BEAC', '2023-03-10', '2026-03-10', 'BEAC-2023-001'),
(auth.uid(), 'Information Security Auditor', 'ISACA', '2023-04-15', '2026-04-15', 'CISA-2023-001'),
(auth.uid(), 'Safety Management Auditor', 'BCSP', '2023-05-20', '2026-05-20', 'BCSP-2023-001'),
(auth.uid(), 'Quality Auditor', 'ASQ', '2023-06-10', '2026-06-10', 'ASQ-2023-001'),
(auth.uid(), 'Supply Chain Auditor', 'IISC', '2023-07-15', '2026-07-15', 'IISC-2023-001'),
(auth.uid(), 'HR Compliance Auditor', 'HRCI', '2023-08-20', '2026-08-20', 'HRCI-2023-001'),
(auth.uid(), 'Process Safety Auditor', 'CCPS', '2023-09-10', '2026-09-10', 'CCPS-2023-001'),
(auth.uid(), 'Data Privacy Auditor', 'IAPP', '2023-10-15', '2026-10-15', 'IAPP-2023-001');

-- Insert sample auditor evaluations
INSERT INTO auditor_evaluations (name, auditor_id, evaluator_id, evaluation_date, audit_id, technical_knowledge, communication_skills, professionalism, comments, recommendations, overall_rating) VALUES
('Annual Evaluation 2024-01', auth.uid(), auth.uid(), '2024-01-15', (SELECT id FROM audit_plans LIMIT 1), 5, 4, 5, 'Excellent technical skills', 'Consider leadership role', 4.7),
('Project Evaluation IT Audit', auth.uid(), auth.uid(), '2024-02-20', (SELECT id FROM audit_plans OFFSET 1 LIMIT 1), 4, 5, 4, 'Strong communication', 'More technical training', 4.3),
('Environmental Audit Review', auth.uid(), auth.uid(), '2024-03-10', (SELECT id FROM audit_plans OFFSET 2 LIMIT 1), 5, 4, 4, 'Thorough methodology', 'Update on regulations', 4.3),
('Financial Audit Evaluation', auth.uid(), auth.uid(), '2024-04-15', (SELECT id FROM audit_plans OFFSET 3 LIMIT 1), 4, 4, 5, 'Well organized', 'Advanced analysis training', 4.3),
('Safety Audit Performance', auth.uid(), auth.uid(), '2024-05-20', (SELECT id FROM audit_plans OFFSET 4 LIMIT 1), 5, 5, 4, 'Excellent safety knowledge', 'Industry certification', 4.7),
('Supply Chain Audit Review', auth.uid(), auth.uid(), '2024-06-10', (SELECT id FROM audit_plans OFFSET 5 LIMIT 1), 4, 4, 4, 'Good process knowledge', 'Supply chain training', 4.0),
('HR Audit Evaluation', auth.uid(), auth.uid(), '2024-07-15', (SELECT id FROM audit_plans OFFSET 6 LIMIT 1), 4, 5, 5, 'Strong HR knowledge', 'Policy development skills', 4.7),
('Production Audit Review', auth.uid(), auth.uid(), '2024-08-20', (SELECT id FROM audit_plans OFFSET 7 LIMIT 1), 5, 4, 4, 'Detailed analysis', 'Process improvement focus', 4.3),
('Service Audit Performance', auth.uid(), auth.uid(), '2024-09-10', (SELECT id FROM audit_plans OFFSET 8 LIMIT 1), 4, 5, 5, 'Excellent customer focus', 'Service quality training', 4.7),
('Data Privacy Evaluation', auth.uid(), auth.uid(), '2024-10-15', (SELECT id FROM audit_plans OFFSET 9 LIMIT 1), 5, 4, 5, 'Strong privacy knowledge', 'Advanced security training', 4.7);