## Fetching collections

Next, let's say that we want to find all **stories** belonging to the "arts" topic.  That is, all **stories** with a `links.collection` pointing to the "arts" topic.

If we know the GUID of the collection, we can do a query-by-guid:

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
$sdk = new \Pmp\Sdk('https://api.pmp.io', 'myid', 'mysecret');
$doc = $sdk->queryCollection('89944632-fe7c-47df-bc2c-b2036d823f98', array('profile' => 'story'));

if ($doc) {
    $items = $doc->items();
    $count = count($items);
    $total = $items->total();
    echo "COUNT=$count TOTAL=$total\n";
    foreach ($items as $item) {
        echo "  {$item->attributes->title}\n";
    }
}
else {
    echo "got 0 search results back\n";
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

We can also use the **collections** endpoint to query within the collection (see `urn:collectiondoc:query:collection` in [the home doc](https://api.pmp.io)).  We could use a `guid` here, but let's use the **arts** collection alias.

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
$sdk = new \Pmp\Sdk('https://api.pmp.io', 'myid', 'mysecret');
$doc = $sdk->queryCollection('arts', array('profile' => 'story'));

if ($doc) {
    $items = $doc->items();
    $count = count($items);
    $total = $items->total();
    echo "COUNT=$count TOTAL=$total\n";
    foreach ($items as $item) {
        echo "  {$item->attributes->title}\n";
    }
}
else {
    echo "got 0 search results back\n";
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
