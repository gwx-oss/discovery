from collections import OrderedDict
from django.db.models.query import QuerySet


def normalize_list(input_value):
    if isinstance(input_value, (str, int, float)):
        return [input_value]
    elif isinstance(input_value, (tuple, QuerySet)):
        return list(input_value)
    return input_value


def split_fields(fields):
    field_list = []
    
    for field in normalize_list(fields):
        if isinstance(field, str):
            field_list.extend(field.split('__'))
        elif isinstance(field, (list, tuple, QuerySet)):
            field_list.extend(split_fields(field))
        else:
            field_list.append(field)
    
    return field_list


def get_nested_value(data, keys):
    
    def _nested_value(data, keys):
        if keys and data:
            element = keys[0]
                
            if element is not None:
                if isinstance(data, (dict, OrderedDict)):
                    value = data.get(element)
                elif isinstance(data, (list, tuple, QuerySet)):
                    value = data[element]
                    
                return value if len(keys) == 1 else _nested_value(value, keys[1:])
    
        return None

    return _nested_value(data, split_fields(keys))
    