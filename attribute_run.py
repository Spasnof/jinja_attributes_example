from jinja2 import Environment, PackageLoader


class MarketingAttributes():
    # NOTE: not exactly sure if a class is needed.
    # Was looking to alter param rather than pass by reference.
    def __init__(self):
        self.param = {
            'params': {
                'attributes': [
                    {'name': 'login_history',
                     'columns': [
                         'last_login_date',
                         'first_login_date',
                         'total_hours_played']
                     },
                    {'name': 'purchases',
                     'columns': [
                         'total_purchase_usd',
                         'last_purchase_amount',
                         'last_purchase_product_id',
                     ]
                     }
                ],
                'username': 'jproffitt'
            }
        }
        self.load_param_sql()

    def load_param_sql(self):
        """
        Initializes the param attributes with the corrisponding sql
        :return:
        """
        attributes = self.param['params']['attributes']
        for attribute in attributes:
            attribute_sql_file = attribute['name'] + '.sql'
            attribute['stmt'] = open(f'./marketing/attributes/{attribute_sql_file}').read()


ma = MarketingAttributes()
env = Environment(
    loader=PackageLoader(package_name='marketing', package_path='templates'),
autoescape=True)
template = env.get_template('master_attribute_template.sql')
print(template.render(ma.param, foo='jproffitt'))
