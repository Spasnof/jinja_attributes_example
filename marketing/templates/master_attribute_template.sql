{# TODO figure out why I can't reference outside the scope of params in a loop #}
-- CREATE TEMP TABLES
{% for attribute in params.attributes %}
CREATE VOLATILE TABLE {{ foo }}.{{ attribute.name }} AS
{{ attribute.stmt }}
WITH DATA ON COMMIT PRESERVE ROWS;
{% endfor %}
-- CREATE UNION SET OF ALL DISTINCT ACCOUNT_IDs
CREATE VOLATILE TABLE {{ foo }}.ALL_IDS AS {% for attribute in params.attributes %}
SELECT  account_id FROM {{ foo }}.{{ attribute.name }}
{% if not loop.last %} union {% endif %}
 {% endfor %} WITH DATA ON COMMIT PRESERVE ROWS;
-- SELECT FROM THAT SET
SELECT
 a.account_id,
{% for attribute in params.attributes %} /* {{ attribute.name }} */
{% for c in attribute.columns %} {{ attribute.name }}.{{ c }},
{% endfor %}{% endfor %} FROM {{ foo }}.ALL_IDS a
{% for attribute in params.attributes %}
left join {{ foo }}.{{ attribute.name }} as {{ attribute.name }}
    on a.account_id = {{ attribute.name }}.account_id {% endfor %}

{# TODO CDC STMTS #}