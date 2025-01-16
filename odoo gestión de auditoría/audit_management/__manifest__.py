{
    'name': 'Audit Management',
    'version': '18.0.1.0.0',
    'category': 'Management',
    'summary': 'Complete Audit Management System with AI Assistant',
    'description': """
        Comprehensive Audit Management System including:
        - Audit Programs
        - Audit Notifications
        - Audit Plans
        - Audit Findings
        - Audit Reports
        - Non-Conformity Management
        - Action Plans
        - Auditor Management
        - Auditor Evaluation
        - AI Assistant Bot
        - Dashboard & Analytics
        - PDF Reports
        - Business Intelligence
    """,
    'author': 'Your Company',
    'website': 'https://www.yourcompany.com',
    'depends': [
        'base',
        'mail',
        'web',
        'board',           # For dashboard
        'report_xlsx',     # For Excel reports
        'web_dashboard',   # For BI dashboards
        'hr',             # For employee integration
        'calendar',       # For audit scheduling
        'document',       # For document management
        'quality',        # For quality management integration
    ],
    'data': [
        'security/audit_security.xml',
        'security/ir.model.access.csv',
        'views/audit_program_views.xml',
        'views/audit_notification_views.xml',
        'views/audit_plan_views.xml',
        'views/audit_finding_views.xml',
        'views/audit_report_views.xml',
        'views/nonconformity_views.xml',
        'views/action_plan_views.xml',
        'views/auditor_views.xml',
        'views/auditor_evaluation_views.xml',
        'views/menu_views.xml',
        'views/audit_dashboard_views.xml',
        'reports/audit_report_templates.xml',
        'reports/audit_reports.xml',
        'data/sequence.xml',
        'data/dashboard_data.xml',
    ],
    'assets': {
        'web.assets_backend': [
            'audit_management/static/src/js/audit_bot.js',
            'audit_management/static/src/js/audit_dashboard.js',
            'audit_management/static/src/js/audit_charts.js',
            'audit_management/static/src/css/audit_styles.css',
            'audit_management/static/src/css/dashboard_styles.css',
        ],
    },
    'application': True,
    'installable': True,
    'auto_install': False,
    'license': 'LGPL-3',
}