# -*- coding: utf-8 -*-
# Generated by Django 1.10 on 2018-07-18 01:30
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('login_registration', '0003_auto_20180718_0126'),
    ]

    operations = [
        migrations.AlterField(
            model_name='post',
            name='latitude',
            field=models.CharField(max_length=60),
        ),
        migrations.AlterField(
            model_name='post',
            name='longitude',
            field=models.CharField(max_length=60),
        ),
    ]