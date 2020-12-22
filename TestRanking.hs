import IndoorTrackNationalRanking
{--IndoorTrackNatioanlRanking can be used to input raw results (unconverted times)
of runners and will rank the runners in order by accounting for the track type
(Banked or Flat) with the convertion used by the NCAA. This can be used to replicate
the offical national ranking the NCAA uses to select the top 16 (top 17 for Women)
runners in the nation for each event that will qualify for the National Championship
Time min:sec.dec -> min,sec,dec
--}


--creates an unorderlist of runner & performances`
test000 = addList [(initRunner "Braxton Schuldt" Flat Mens5k (15,06,12)),(initRunner "Ajay Sarathy" Banked Mens3k (8,38,00)),(initRunner "Max NotARealPerson" Flat Mens3k (8,40,00)), (initRunner "Sophie Wolmer" Flat Womens3k (10,00,63)), (initRunner "Niamh Kenny" Flat Womens3k (9,51,34))] []
--adds more to the list made in test000
test00 = addList [(initRunner "Mathew Wilkinson" Flat Mens3k (8,11,52)), (initRunner "Aidan Ryan" Banked Mens3k (8,08,96)), (initRunner "Sarah Gayer" Banked Womens3k (9,53,53))] (test000)
test0 = addList [(initRunner "Billy Massey" Flat Mens3k (8,38,00)), (initRunner "Dillan Spector" Banked Mens3k (8,44,34)), (initRunner "Ajay Sarathy" Flat Mens5k (15,03,40)), (initRunner "Eline Laurent" Banked Womens3k (10,37,34)), (initRunner "Genny Corcoran" Banked Womens3k (9,49,39))] (test00)
--tests initRunner which is used to create a "Runner"
test1 = initRunner "Ajay Sarathy" Banked Mens3k (9,38,00)
--tests initList which creates a Fulllist with one runner
test2 = initList (initRunner "Ajay Sarathy" Banked Mens3k (9,38,00))
--creates a ranking of "Runners" for a specified event out of the list made in test0
test3 = getEventRanking (test0) Mens3k
--creates ranking like test2 but only display the names of the runners
test4 = getNameRanking (test0) Mens3k
--creates a list with all performances converted to flat track
test5 = getConvertedList (test0)
--creates a ranking for the men's 3k just like test3 but this time displays all tiems convert to flat track
test6 = getEventRanking (test5) Mens3k
--ranks the Womens3k
test7 = getEventRanking (test0) Womens3k
