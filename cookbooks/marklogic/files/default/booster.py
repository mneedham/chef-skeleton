#!/usr/bin/python
import os
import sys
import urllib
import urllib2

def configureAuthHttpProcess(server_name, uname, password):
    passman = urllib2.HTTPPasswordMgrWithDefaultRealm()
    passman.add_password(None, server_name, uname, password)
    authhandler = urllib2.HTTPDigestAuthHandler(passman)
    opener = urllib2.build_opener(authhandler)
    urllib2.install_opener(opener)

def booster(server_name, args = ""):
    http(server_name, "booster.xqy", args)

def license(server_name):
    http(server_name, "license-go.xqy", { 'license-key':"1F6B-7ED3-EE57-F576-C1A8-E6B7-CD35-FDAF-2E71-EF5C-3CA3", 'licensee':"Springer - Michael Hughes - Evaluation" })

def initialize_go(server_name):
    http(server_name, "initialize-go.xqy")

def agree_go(server_name):
    http(server_name, "agree-go.xqy", { 'accepted-agreement':"evaluation" })

def security_install_go(server_name):
    http(server_name, "security-install-go.xqy", { 'auto':'true', 'user':'admin', 'password1':'admin', 'password2':'admin', 'realm':'public' })

def testing_admin_connection(server_name):
    http(server-name, "default.xqy")

def http(server_name, xquery_file, args = ""):
    request = urllib2.Request(server_name + "/" + xquery_file)
    if args == "":
        response = urllib2.urlopen(request)
    else:
        response = urllib2.urlopen(request, urllib.urlencode(args))
