SELECT * FROM firstkorea.foodstore;
use firstkorea;

# idf
# log(1 + (docCount - docFreq + 0.5) / (docFreq + 0.5))
# docCount
select count(*) from foodstore;
# docFreq
select count(*) from foodstore where storeReview like '%스시%';

select log(1 + (121 - 29 + 0.5) / (29 + 0.5));
select log(1 + ((select count(*) from foodstore) - (select count(*) from foodstore where storeReview like '%스시%') + 0.5) / ((select count(*) from foodstore where storeReview like '%스시%') + 0.5))
;

# tf
# (freq * (k1 + 1)) / (freq + k1 * (1 - b + b * fieldLength / avgFieldLength))
# term freq
SELECT storeSeqNo, char_length(storeReview)-char_length(replace(storeReview,'스시','')) as freq
from foodstore;
# avgFieldLength
select avg(char_length(storeReview)) from foodstore;
# fieldLength
select storeSeqNo, char_length(storeReview) as fieldLength from foodstore;


# bm25
select storeSeqNo, storeName, storeScore, storeCategory, priceRange, storeAddress, storeImage, 
(log(1 + ((select count(*) from foodstore) - (select count(*) from foodstore where storeReview like '%스시%') + 0.5) / ((select count(*) from foodstore where storeReview like '%스시%') + 0.5))) *
(char_length(storeReview)-char_length(replace(storeReview,'스시',''))) * (1.2 + 1)
/
(char_length(storeReview)-char_length(replace(storeReview,'스시','')) + 1.2 *
(1 - 0.75 + (0.75 * char_length(storeReview)) / (select avg(char_length(storeReview)) from foodstore ))
) as bm25result

from foodstore order by bm25result desc limit 5;

select 1.4733057381095203 * 2.18518;