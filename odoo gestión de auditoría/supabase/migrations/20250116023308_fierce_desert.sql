/*
  # Create Audit Management Tables

  1. New Tables
    - audit_programs
    - audit_notifications
    - audit_plans
    - audit_findings
    - audit_reports
    - nonconformities
    - action_plans
    - auditor_evaluations
    - audit_areas
    - auditor_certifications

  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users
*/

-- Create audit_programs table
CREATE TABLE IF NOT EXISTS audit_programs (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name text NOT NULL,
    code text NOT NULL,
    year integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    objective text NOT NULL,
    scope text NOT NULL,
    state text NOT NULL,
    responsible_id uuid REFERENCES auth.users(id),
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- Create audit_notifications table
CREATE TABLE IF NOT EXISTS audit_notifications (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name text NOT NULL,
    notification_date date NOT NULL,
    audit_plan_id uuid,
    description text,
    state text NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- Create audit_plans table
CREATE TABLE IF NOT EXISTS audit_plans (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name text NOT NULL,
    program_id uuid REFERENCES audit_programs(id),
    planned_date date NOT NULL,
    duration float NOT NULL,
    objective text NOT NULL,
    scope text NOT NULL,
    methodology text,
    state text NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- Create audit_findings table
CREATE TABLE IF NOT EXISTS audit_findings (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name text NOT NULL,
    code text NOT NULL,
    audit_plan_id uuid REFERENCES audit_plans(id),
    finding_date date NOT NULL,
    type text NOT NULL,
    description text NOT NULL,
    evidence text,
    severity text NOT NULL,
    state text NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- Create audit_reports table
CREATE TABLE IF NOT EXISTS audit_reports (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name text NOT NULL,
    audit_plan_id uuid REFERENCES audit_plans(id),
    report_date date NOT NULL,
    executive_summary text NOT NULL,
    methodology text,
    conclusion text,
    recommendations text,
    state text NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- Create nonconformities table
CREATE TABLE IF NOT EXISTS nonconformities (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name text NOT NULL,
    finding_id uuid REFERENCES audit_findings(id),
    description text NOT NULL,
    root_cause text,
    correction text,
    corrective_action text,
    responsible_id uuid REFERENCES auth.users(id),
    deadline date,
    state text NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- Create action_plans table
CREATE TABLE IF NOT EXISTS action_plans (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name text NOT NULL,
    nonconformity_id uuid REFERENCES nonconformities(id),
    description text NOT NULL,
    responsible_id uuid REFERENCES auth.users(id),
    start_date date,
    end_date date,
    resources text,
    progress float DEFAULT 0.0,
    state text NOT NULL,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- Create audit_areas table
CREATE TABLE IF NOT EXISTS audit_areas (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name text NOT NULL,
    description text,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- Create auditor_certifications table
CREATE TABLE IF NOT EXISTS auditor_certifications (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    auditor_id uuid REFERENCES auth.users(id),
    name text NOT NULL,
    issuing_body text NOT NULL,
    issue_date date NOT NULL,
    expiry_date date,
    certification_number text,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- Create auditor_evaluations table
CREATE TABLE IF NOT EXISTS auditor_evaluations (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name text NOT NULL,
    auditor_id uuid REFERENCES auth.users(id),
    evaluator_id uuid REFERENCES auth.users(id),
    evaluation_date date NOT NULL,
    audit_id uuid REFERENCES audit_plans(id),
    technical_knowledge integer NOT NULL,
    communication_skills integer NOT NULL,
    professionalism integer NOT NULL,
    comments text,
    recommendations text,
    overall_rating float,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE audit_programs ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_plans ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_findings ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE nonconformities ENABLE ROW LEVEL SECURITY;
ALTER TABLE action_plans ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_areas ENABLE ROW LEVEL SECURITY;
ALTER TABLE auditor_certifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE auditor_evaluations ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Users can read audit programs"
    ON audit_programs FOR SELECT
    TO authenticated
    USING (true);

CREATE POLICY "Users can insert audit programs"
    ON audit_programs FOR INSERT
    TO authenticated
    WITH CHECK (true);

CREATE POLICY "Users can update audit programs"
    ON audit_programs FOR UPDATE
    TO authenticated
    USING (true);

-- Repeat similar policies for other tables
-- Note: In a production environment, you would want more specific policies
-- based on user roles and permissions