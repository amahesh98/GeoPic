# -*- coding: utf-8 -*-
# Generated by Django 1.10 on 2018-07-18 01:26
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('login_registration', '0002_post_location'),
    ]

    operations = [
        migrations.RenameField(
            model_name='post',
            old_name='longtitude',
            new_name='longitude',
        ),
    ]
