#!/usr/bin/env python

import MySQLdb
import configparser
import sys

def check_mysql_connection(**kwargs):
    while True:
        try:
            conn = MySQLdb.connect(**kwargs)
        except:
            continue
        else:
            return True

if __name__ == '__main__':

    config = configparser.ConfigParser()
    config.read('/run/secrets/djangodb.cnf')

    try:
        db = dict(config['client'])
        db['port'] =int(db['port'])
    except KeyError as e:
        print("[django] db config file for django is not in proper format.")
        sys.exit(1)
    else:
        check_mysql_connection(**db)
    