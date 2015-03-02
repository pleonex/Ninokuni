# -*- coding: utf-8 -*-
###############################################################################
#  Connect to game-kouryaku.info to download all the magic news - V1.0        #
#  Copyright 2015 Benito Palacios (aka pleonex)                               #
#                                                                             #
#  Licensed under the Apache License, Version 2.0 (the "License");            #
#  you may not use this file except in compliance with the License.           #
#  You may obtain a copy of the License at                                    #
#                                                                             #
#      http://www.apache.org/licenses/LICENSE-2.0                             #
#                                                                             #
#  Unless required by applicable law or agreed to in writing, software        #
#  distributed under the License is distributed on an "AS IS" BASIS,          #
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   #
#  See the License for the specific language governing permissions and        #
#  limitations under the License.                                             #
###############################################################################

import scrapy
from magicnews.items import MagicnewsItem

URL = "http://game-kouryaku.info/ninokuni/tuusin"
EXT = ".html"
DATES = ["1012", "1101", "1102", "1103", "1104", "1105", "1106", "1107",
         "1108", "1109", "1110", "1111", ""]
DATE_REGEX = "([^" + u'\uff08' + u'\uff09' + u'\u6708' + u'\u65e5' + "]+)"


class MagicnewsSpider(scrapy.Spider):
    name = 'magicnews'
    allowed_domains = ['game-kouryaku.info']
    start_urls = [URL + month + EXT for month in DATES]

    def parse(self, response):
        for entry in reversed(response.xpath('//p[@class="madou"]')):
            news = MagicnewsItem()
            header = entry.xpath('span/text()').re(DATE_REGEX)
            news['title'] = header[0]
            news['date'] = header[2] + "/" + header[1]
            news['body'] = entry.xpath('text()')[0].extract()
            yield news
