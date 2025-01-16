from odoo import models, fields, api
from datetime import datetime, timedelta

class AuditDashboard(models.Model):
    _name = 'audit.dashboard'
    _description = 'Audit Dashboard'
    _auto = False

    name = fields.Char('Name')
    total_audits = fields.Integer('Total Audits')
    pending_audits = fields.Integer('Pending Audits')
    completed_audits = fields.Integer('Completed Audits')
    open_findings = fields.Integer('Open Findings')
    critical_findings = fields.Integer('Critical Findings')
    overdue_actions = fields.Integer('Overdue Actions')
    audit_effectiveness = fields.Float('Audit Effectiveness %')
    
    def init(self):
        tools.drop_view_if_exists(self.env.cr, self._table)
        self.env.cr.execute("""
            CREATE or REPLACE VIEW %s as (
                WITH audit_stats AS (
                    SELECT
                        count(*) as total_audits,
                        sum(CASE WHEN state = 'completed' THEN 1 ELSE 0 END) as completed_audits,
                        sum(CASE WHEN state = 'planned' THEN 1 ELSE 0 END) as pending_audits
                    FROM audit_plan
                ),
                finding_stats AS (
                    SELECT
                        count(*) as total_findings,
                        sum(CASE WHEN state != 'closed' THEN 1 ELSE 0 END) as open_findings,
                        sum(CASE WHEN severity = 'critical' AND state != 'closed' THEN 1 ELSE 0 END) as critical_findings
                    FROM audit_finding
                ),
                action_stats AS (
                    SELECT
                        count(*) as overdue_actions
                    FROM audit_action_plan
                    WHERE end_date < CURRENT_DATE AND state != 'completed'
                )
                SELECT
                    1 as id,
                    'Audit Dashboard' as name,
                    a.total_audits,
                    a.pending_audits,
                    a.completed_audits,
                    f.open_findings,
                    f.critical_findings,
                    act.overdue_actions,
                    CASE 
                        WHEN a.total_audits > 0 
                        THEN (a.completed_audits::float / a.total_audits) * 100 
                        ELSE 0 
                    END as audit_effectiveness
                FROM audit_stats a
                CROSS JOIN finding_stats f
                CROSS JOIN action_stats act
            )
        """ % self._table)

    def get_audit_trend_data(self):
        self.env.cr.execute("""
            SELECT 
                date_trunc('month', planned_date) as month,
                count(*) as audit_count
            FROM audit_plan
            WHERE planned_date >= CURRENT_DATE - interval '12 months'
            GROUP BY 1
            ORDER BY 1
        """)
        return self.env.cr.dictfetchall()

    def get_finding_by_type(self):
        self.env.cr.execute("""
            SELECT 
                type,
                count(*) as count
            FROM audit_finding
            GROUP BY type
        """)
        return self.env.cr.dictfetchall()

    def get_audit_kpis(self):
        return {
            'total_audits': self.total_audits,
            'pending_audits': self.pending_audits,
            'completed_audits': self.completed_audits,
            'open_findings': self.open_findings,
            'critical_findings': self.critical_findings,
            'overdue_actions': self.overdue_actions,
            'audit_effectiveness': round(self.audit_effectiveness, 2)
        }