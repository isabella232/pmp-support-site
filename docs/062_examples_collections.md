## Fetching collections

Alright, now say we want to find all **stories** belonging to the "arts" topic.  That is - all **stories** with a `links.collection` pointing to the "arts" topic.

Knowing the guid of the collection, we can do a query-by-guid:

```shell
curl -H "Authorization: Bearer 3f2401ae1a74adf8b14a638a" -X GET "https://api.pmp.io/docs?collection=89944632-fe7c-47df-bc2c-b2036d823f98"

# returns a big collection+doc json string
```

```javascript
var PmpSdk = require('pmpsdk');
var sdk = new PmpSdk({client_id: '1', client_secret: '2', host: 'https://api.pmp.io'});

sdk.queryDocs({collection: '89944632-fe7c-47df-bc2c-b2036d823f98', profile: 'story'}, (query, resp) {
  console.log(resp.status);          // 200
  console.log(resp.success);         // true
  console.log(query.items.length);   // 10
  console.log(query.total());        // 999
  console.log(query.items[0].attributes.title); // "Some doc title"
});
```

```perl
my $client = Net::PMP::Client->new(id => '1', secret => '2', host => 'https://api.pmp.io');
my $search = $client->search({collection => '89944632-fe7c-47df-bc2c-b2036d823f98', profile => 'story'});

my $results = $search->get_items();
printf( "total: %s\n", $results->total );
while ( my $r = $results->next ) {
   printf( '%s: %s [%s]', $results->count, $r->get_uri, $r->get_title, ) );
}
```

```php
<?php
$auth = new \Pmp\Sdk\AuthClient('https://api.pmp.io', 'myid', 'mysecret');

$opts = array('collection' => '89944632-fe7c-47df-bc2c-b2036d823f98', 'profile' => 'story');
$search = \Pmp\Sdk\CollectionDocJson::search($host, $auth, $opts);

if ($search) {
    echo count($search->items);
    echo $search->items()->total();
    foreach ($search->items()->toArray() as $item) {
        echo $item->attributes->title;
    }
}
?>
```

```ruby
pmp = PMP::Client.new(client_id: '1', client_secret: '2', endpoint: 'https://api.pmp.io')
search = pmp.query['urn:collectiondoc:query:docs'].where(collection: '89944632-fe7c-47df-bc2c-b2036d823f98', profile: 'story')

if search && search.navigation && search.navigation[:self]
  puts "total = #{search.navigation[:self].totalitems}"
end
search.items.each do |item|
  puts "item = #{item.title} -> #{item.published}"
end
```

Or we can use the **collections** endpoint to query within the collection (see `urn:collectiondoc:query:collection` in [the home doc](https://api.pmp.io)).  We could use a `guid` here, but let's use the **arts** collection alias.

```shell
curl -H "Authorization: Bearer 3f2401ae1a74adf8b14a638a" -X GET "https://api.pmp.io/collection/arts?profile=story"

# returns a big collection+doc json string
```

```javascript
var PmpSdk = require('pmpsdk');
var sdk = new PmpSdk({client_id: '1', client_secret: '2', host: 'https://api.pmp.io'});

sdk.queryCollection('arts', {profile: 'story'}, (query, resp) {
  console.log(resp.status);          // 200
  console.log(resp.success);         // true
  console.log(query.items.length);   // 10
  console.log(query.total());        // 999
  console.log(query.items[0].attributes.title); // "Some doc title"
});
```

```perl
my $client = Net::PMP::Client->new(id => '1', secret => '2', host => 'https://api.pmp.io');
my $root   = $client->get_doc();
my $uri    = $root->query('urn:collectiondoc:query:collection')->as_uri({guid => 'arts', profile => 'story'});
my $search = $client->get_doc($uri);

my $results = $search->get_items();
printf( "total: %s\n", $results->total );
while ( my $r = $results->next ) {
   printf( '%s: %s [%s]', $results->count, $r->get_uri, $r->get_title, ) );
}
```

```php
<?php
$auth = new \Pmp\Sdk\AuthClient('https://api.pmp.io', 'myid', 'mysecret');
$home = new \Pmp\Sdk\CollectionDocJson('https://api.pmp.io', $auth);

$opts = array('guid' => 'arts', 'profile' => 'story');
try {
    $search = $home->query('urn:collectiondoc:query:collection')->submit($opts);
    foreach ($search->items()->toArray() as $item) {
        echo $item->attributes->title;
    }
}
catch (Exception $ex) {
    if ($ex->getCode() == 404) {
        echo "Got 0 search results back";
    }
}
?>
```

```ruby
pmp = PMP::Client.new(client_id: '1', client_secret: '2', endpoint: 'https://api.pmp.io')
search = pmp.query['urn:collectiondoc:query:collection'].where(guid: 'arts', profile: 'story')

if search && search.navigation && search.navigation[:self]
  puts "total = #{search.navigation[:self].totalitems}"
end
search.items.each do |item|
  puts "item = #{item.title} -> #{item.published}"
end
```
