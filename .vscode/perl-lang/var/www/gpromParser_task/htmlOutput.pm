{"vars":[{"signature":{"documentation":" package HTMLOutput;\n \u00d0\u0092\u00d0\u00bf\u00d0\u00be\u00d1\u0081\u00d0\u00bb\u00d0\u00b5\u00d0\u00b4\u00d1\u0081\u00d1\u0082\u00d0\u00b2\u00d0\u00b8\u00d0\u00b8 \u00d0\u00bc\u00d0\u00be\u00d0\u00b6\u00d0\u00b5\u00d0\u00bc \u00d1\u0083\u00d0\u00bf\u00d0\u00b0\u00d0\u00ba\u00d0\u00be\u00d0\u00b2\u00d0\u00b0\u00d1\u0082\u00d1\u008c \u00d1\u0080\u00d0\u00b0\u00d0\u00b4\u00d0\u00b8 \u00d0\u00ba\u00d1\u0080\u00d0\u00b0\u00d1\u0081\u00d0\u00b8\u00d0\u00b2\u00d1\u008b\u00d1\u0085 HTMLOutput::searchResultsPrint\n \u00d0\u009b\u00d1\u008e\u00d0\u00b1\u00d0\u00be\u00d0\u00bf\u00d1\u008b\u00d1\u0082\u00d0\u00bd\u00d0\u00be, \u00d1\u0087\u00d1\u0082\u00d0\u00be Perl CRiTiC \u00d0\u00bd\u00d0\u00b5\u00d1\u0083\u00d1\u0081\u00d1\u0082\u00d0\u00b0\u00d0\u00bd\u00d0\u00bd\u00d0\u00be \u00d1\u0080\u00d1\u0083\u00d0\u00b3\u00d0\u00b0\u00d0\u00b5\u00d1\u0082 \u00d0\u00bc\u00d0\u00b5\u00d0\u00bd\u00d1\u008f \u00d0\u00b7\u00d0\u00b0 \u00d0\u00ba\u00d1\u008d\u00d0\u00bc\u00d0\u00b5\u00d0\u00bb\u00d0\u009d\u00d1\u008d\u00d0\u00b9\u00d0\u00bc\u00d1\u008b.\n \u00d0\u00ad\u00d1\u0082\u00d0\u00be \u00d0\u00b2\u00d1\u0081\u00d1\u0091 \u00d1\u0080\u00d0\u00b0\u00d1\u0081\u00d0\u00bb\u00d0\u00b0\u00d0\u00b1\u00d0\u00bb\u00d0\u00b5\u00d0\u00bd\u00d0\u00bd\u00d1\u008b\u00d0\u00b5 \u00d0\u00bf\u00d1\u0080\u00d0\u00b8\u00d0\u00b2\u00d1\u008b\u00d1\u0087\u00d0\u00ba\u00d0\u00b8 PHP.\n## \u00d0\u00a1\u00d1\u0082\u00d1\u0080\u00d0\u00be\u00d0\u00ba\u00d0\u00b0 \u00d0\u00bf\u00d0\u00be\u00d0\u00b8\u00d1\u0081\u00d0\u00ba\u00d0\u00b0, \u00d1\u0081 \u00d1\u0081\u00d0\u00be\u00d1\u0085\u00d1\u0080\u00d0\u00b0\u00d0\u00bd\u00d0\u00b5\u00d0\u00bd\u00d0\u00b8\u00d0\u00b5\u00d0\u00bc \u00d0\u00b2\u00d0\u00b2\u00d0\u00be\u00d0\u00b4\u00d0\u00b0.","label":"searchForm($search,$baseurl)","parameters":[{"label":"$search"},{"label":"$baseurl"}]},"line":7,"definition":"sub","range":{"start":{"character":0,"line":7},"end":{"character":9999,"line":19}},"detail":"($search,$baseurl)","name":"searchForm","children":[{"containerName":"searchForm","kind":13,"name":"$search","definition":"my","line":8,"localvar":"my"},{"kind":13,"containerName":"searchForm","line":8,"name":"$baseurl"},{"line":9,"kind":13,"containerName":"searchForm","name":"$baseurl"}],"containerName":"main::","kind":12},{"definition":"sub","line":22,"signature":{"documentation":"## \u00d0\u00b2\u00d1\u008b\u00d0\u00b2\u00d0\u00be\u00d0\u00b4 \u00d1\u0080\u00d0\u00b5\u00d0\u00b7\u00d1\u0083\u00d0\u00bb\u00d1\u008c\u00d1\u0082\u00d0\u00b0\u00d1\u0082\u00d0\u00be\u00d0\u00b2 \u00d0\u00bf\u00d0\u00be\u00d0\u00b8\u00d1\u0081\u00d0\u00ba\u00d0\u00b0:","label":"searchResultsPrint($search,$dbHandler)","parameters":[{"label":"$search"},{"label":"$dbHandler"}]},"name":"searchResultsPrint","children":[{"name":"$search","kind":13,"containerName":"searchResultsPrint","line":24,"localvar":"my","definition":"my"},{"name":"$dbHandler","line":24,"containerName":"searchResultsPrint","kind":13},{"containerName":"searchResultsPrint","kind":13,"line":24,"name":"$baseurl"},{"line":24,"kind":13,"containerName":"searchResultsPrint","name":"$resultsPerPage"},{"line":24,"kind":13,"containerName":"searchResultsPrint","name":"$fromPage"},{"name":"$query","containerName":"searchResultsPrint","kind":13,"definition":"my","line":27,"localvar":"my"},{"kind":13,"containerName":"searchResultsPrint","name":"$sth","line":28,"localvar":"my","definition":"my"},{"containerName":"searchResultsPrint","kind":13,"line":28,"name":"$dbHandler"},{"kind":12,"containerName":"searchResultsPrint","line":28,"name":"prepare"},{"line":28,"containerName":"searchResultsPrint","kind":13,"name":"$query"},{"name":"$sth","kind":13,"containerName":"searchResultsPrint","line":29},{"line":29,"kind":12,"containerName":"searchResultsPrint","name":"execute"},{"line":30,"localvar":"my","definition":"my","containerName":"searchResultsPrint","kind":13,"name":"@data"},{"line":30,"containerName":"searchResultsPrint","kind":13,"name":"$sth"},{"name":"fetchrow_array","kind":12,"containerName":"searchResultsPrint","line":30},{"name":"$results_count","containerName":"searchResultsPrint","kind":13,"line":32},{"name":"@data","containerName":"searchResultsPrint","kind":13,"line":32},{"name":"$results_count","containerName":"searchResultsPrint","kind":13,"line":33},{"line":37,"localvar":"my","definition":"my","containerName":"searchResultsPrint","kind":13,"name":"$link"},{"containerName":"searchResultsPrint","kind":13,"line":37,"name":"$search"},{"name":"$pager","containerName":"searchResultsPrint","kind":13,"line":38,"definition":"my","localvar":"my"},{"line":38,"kind":13,"containerName":"searchResultsPrint","name":"$results_count"},{"name":"$resultsPerPage","line":38,"containerName":"searchResultsPrint","kind":13},{"name":"$fromPage","kind":13,"containerName":"searchResultsPrint","line":38},{"line":38,"containerName":"searchResultsPrint","kind":13,"name":"$link"},{"name":"$pager","kind":13,"containerName":"searchResultsPrint","line":39},{"name":"$fromPage","containerName":"searchResultsPrint","kind":13,"line":41},{"kind":13,"containerName":"searchResultsPrint","line":41,"name":"$fromPage"},{"containerName":"searchResultsPrint","kind":13,"line":41,"name":"$resultsPerPage"},{"name":"$resultsPerPage","line":41,"kind":13,"containerName":"searchResultsPrint"},{"name":"$query","line":42,"containerName":"searchResultsPrint","kind":13},{"name":"$sth","containerName":"searchResultsPrint","kind":13,"line":43},{"containerName":"searchResultsPrint","kind":13,"line":43,"name":"$dbHandler"},{"name":"prepare","containerName":"searchResultsPrint","kind":12,"line":43},{"line":43,"kind":13,"containerName":"searchResultsPrint","name":"$query"},{"name":"$sth","line":44,"containerName":"searchResultsPrint","kind":13},{"line":44,"kind":12,"containerName":"searchResultsPrint","name":"execute"},{"name":"$bgcolor","line":47,"kind":13,"containerName":"searchResultsPrint"},{"line":49,"kind":13,"containerName":"searchResultsPrint","name":"@data"},{"name":"$sth","kind":13,"containerName":"searchResultsPrint","line":49},{"line":49,"containerName":"searchResultsPrint","kind":12,"name":"fetchrow_array"},{"containerName":"searchResultsPrint","kind":13,"line":51,"name":"$date"},{"name":"$data","containerName":"searchResultsPrint","kind":13,"line":51},{"line":52,"containerName":"searchResultsPrint","kind":13,"name":"$internal_ID"},{"containerName":"searchResultsPrint","kind":13,"line":52,"name":"$data"},{"name":"$log_string","containerName":"searchResultsPrint","kind":13,"line":53},{"name":"$data","containerName":"searchResultsPrint","kind":13,"line":53},{"line":54,"containerName":"searchResultsPrint","kind":13,"name":"$email"},{"kind":13,"containerName":"searchResultsPrint","line":54,"name":"$data"},{"name":"$bgcolor","kind":13,"containerName":"searchResultsPrint","line":55},{"name":"$bgcolor","line":55,"kind":13,"containerName":"searchResultsPrint"},{"name":"$bgcolor","containerName":"searchResultsPrint","kind":13,"line":55},{"name":"$log_string","containerName":"searchResultsPrint","kind":13,"line":56},{"name":"$results_count","kind":13,"containerName":"searchResultsPrint","line":64},{"name":"$pager","kind":13,"containerName":"searchResultsPrint","line":65}],"kind":12,"containerName":"main::","range":{"start":{"line":22,"character":0},"end":{"line":66,"character":9999}},"detail":"($search,$dbHandler)"},{"name":"Habra_pager","kind":12,"line":38},{"definition":"sub","line":69,"signature":{"documentation":"","parameters":[{"label":"$$$$"}],"label":"Habra_pager($$$$)"},"children":[{"containerName":"Habra_pager","kind":13,"name":"$count","line":76,"definition":"my","localvar":"my"},{"kind":13,"containerName":"Habra_pager","name":"$perPage","line":77,"localvar":"my","definition":"my"},{"definition":"my","line":78,"localvar":"my","name":"$curPage","kind":13,"containerName":"Habra_pager"},{"containerName":"Habra_pager","kind":13,"name":"$link","definition":"my","line":79,"localvar":"my"},{"name":"$linkCount","containerName":"Habra_pager","kind":13,"definition":"my","line":81,"localvar":"my"},{"line":81,"kind":13,"containerName":"Habra_pager","name":"$count"},{"containerName":"Habra_pager","kind":13,"line":81,"name":"$perPage"},{"line":82,"localvar":"my","definition":"my","kind":13,"containerName":"Habra_pager","name":"$start"},{"name":"$curPage","containerName":"Habra_pager","kind":13,"line":82},{"line":83,"kind":13,"containerName":"Habra_pager","name":"$start"},{"kind":13,"containerName":"Habra_pager","line":83,"name":"$start"},{"definition":"my","line":84,"localvar":"my","name":"$stop","kind":13,"containerName":"Habra_pager"},{"line":84,"containerName":"Habra_pager","kind":13,"name":"$curPage"},{"name":"$stop","containerName":"Habra_pager","kind":13,"line":86},{"name":"$linkCount","line":86,"kind":13,"containerName":"Habra_pager"},{"kind":13,"containerName":"Habra_pager","line":86,"name":"$stop"},{"name":"$linkCount","line":86,"containerName":"Habra_pager","kind":13},{"name":"$out","containerName":"Habra_pager","kind":13,"definition":"my","line":88,"localvar":"my"},{"line":90,"kind":13,"containerName":"Habra_pager","name":"$out"},{"kind":13,"containerName":"Habra_pager","line":90,"name":"$link"},{"name":"$start","line":90,"containerName":"Habra_pager","kind":13},{"line":91,"localvar":"my","definition":"my","name":"$i","containerName":"Habra_pager","kind":13},{"name":"$start","kind":13,"containerName":"Habra_pager","line":91},{"line":91,"kind":13,"containerName":"Habra_pager","name":"$i"},{"name":"$stop","containerName":"Habra_pager","kind":13,"line":91},{"line":91,"kind":13,"containerName":"Habra_pager","name":"$i"},{"line":92,"localvar":"my","definition":"my","name":"$displayLink","containerName":"Habra_pager","kind":13},{"name":"$link","containerName":"Habra_pager","kind":13,"line":92},{"name":"$i","line":92,"containerName":"Habra_pager","kind":13},{"name":"$i","line":94,"containerName":"Habra_pager","kind":13},{"containerName":"Habra_pager","kind":13,"line":94,"name":"$curPage"},{"kind":13,"containerName":"Habra_pager","line":96,"name":"$out"},{"containerName":"Habra_pager","kind":13,"line":98,"name":"$out"},{"line":102,"kind":13,"containerName":"Habra_pager","name":"$out"},{"name":"$link","line":102,"kind":13,"containerName":"Habra_pager"},{"name":"$linkCount","containerName":"Habra_pager","kind":13,"line":102},{"containerName":"Habra_pager","kind":13,"line":102,"name":"$stop"},{"line":102,"kind":13,"containerName":"Habra_pager","name":"$linkCount"},{"name":"$out","kind":13,"containerName":"Habra_pager","line":103},{"name":"$out","containerName":"Habra_pager","kind":13,"line":104}],"name":"Habra_pager","kind":12,"containerName":"main::","range":{"end":{"character":9999,"line":105},"start":{"line":69,"character":0}},"detail":"($$$$)"},{"definition":"sub","line":110,"signature":{"documentation":"","parameters":[{"label":"$title"}],"label":"printHeader($title)"},"children":[],"name":"printHeader","containerName":"main::","kind":12,"range":{"end":{"line":170,"character":9999},"start":{"character":0,"line":110}},"detail":"($title)"},{"name":"charset","kind":12,"line":111},{"name":"header","kind":12,"line":112},{"signature":{"parameters":[],"label":"printFooter()","documentation":""},"definition":"sub","line":173,"range":{"end":{"line":177,"character":9999},"start":{"character":0,"line":173}},"detail":"()","children":[],"name":"printFooter","kind":12,"containerName":"main::"},{"name":"show_menu","children":[{"name":"$numrowsOld","containerName":"show_menu","kind":13,"line":183,"localvar":"my","definition":"my"},{"name":"$minDateOld","line":183,"kind":13,"containerName":"show_menu"},{"name":"$maxDateOld","kind":13,"containerName":"show_menu","line":183},{"line":183,"kind":13,"containerName":"show_menu","name":"$numrowsCache"},{"line":183,"containerName":"show_menu","kind":13,"name":"$minDateCache"},{"line":183,"containerName":"show_menu","kind":13,"name":"$maxDateCache"},{"line":187,"kind":13,"containerName":"show_menu","name":"$numrowsCache"},{"line":189,"containerName":"show_menu","kind":13,"name":"$numrowsOld"},{"line":195,"kind":13,"containerName":"show_menu","name":"$numrowsOld"},{"containerName":"show_menu","kind":13,"line":199,"name":"$numrowsCache"},{"kind":13,"containerName":"show_menu","line":201,"name":"$numrowsCache"},{"line":207,"containerName":"show_menu","kind":13,"name":"$numrowsOld"},{"line":215,"kind":13,"containerName":"show_menu","name":"$numrowsCache"}],"containerName":"main::","kind":12,"range":{"end":{"line":216,"character":9999},"start":{"character":0,"line":182}},"detail":"($$$$$$)","definition":"sub","line":182,"signature":{"label":"show_menu($$$$$$)","parameters":[{"label":"$$$$$$"}],"documentation":"## \u00d0\u00b2\u00d1\u008b\u00d0\u00b2\u00d0\u00be\u00d0\u00b4 \u00d0\u00b1\u00d0\u00bb\u00d0\u00be\u00d0\u00ba\u00d0\u00b0 \u00d1\u0083\u00d0\u00bf\u00d1\u0080\u00d0\u00b0\u00d0\u00b2\u00d0\u00bb\u00d0\u00b5\u00d0\u00bd\u00d0\u00b8\u00d1\u008f \u00d1\u0082\u00d0\u00b0\u00d0\u00b1\u00d0\u00bb\u00d0\u00b8\u00d1\u0086\u00d0\u00b0\u00d0\u00bc\u00d0\u00b8:"}},{"name":"true","kind":12,"line":220}],"version":5}