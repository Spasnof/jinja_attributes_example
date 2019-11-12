# Jinja Attribute Example

Quick hacked together example of a attribute pipeline using jinja templating and sql. Just returns values nothing fancy.
 - The main idea is to start with a [collection](marketing/attributes) of stand alone attribute key,values sql statements.
   - In this case we use a python dictionary config (could be replaced with yml, ini, w/e), this is our contract of what to do with the attribute values. 
- Then to combine them into one [attribute master](marketing/templates/master_attribute_template.sql)
  - This uses Jinja templating to try and reduce the repetition that is inherent with passing around these attribute values and to reduce risk.   


# Notes
- Of note this is assuming that one monolithic attribute table is what you are going for.
  - Allows for a "wheel and spoke" structure where you have decentralized attributes but one transformation pipeline. 
- Jinja Template docs [here](https://jinja.palletsprojects.com/en/2.10.x/templates/)