# Examples

Now for the main event - making authenticated requests against the API.  This covers some common use-cases around interacting with the API, but is by no means exhaustive.  For more information on the format of the data returned by the server, see the [Collection.doc+JSON](#collection-docjson) section below.


## Fetching documents

One of the basic PMP usages is to fetch a single document.  For instance, let's fetch the "arts topic" document, with a guid of `89944632-fe7c-47df-bc2c-b2036d823f98`...

```shell
curl -H "Authorization: Bearer 3f2401ae1a74adf8b14a638a" -X GET "https://api.pmp.io/docs/89944632-fe7c-47df-bc2c-b2036d823f98"

# returns a big collection+doc json string
```

```javascript
var PmpSdk = require('pmpsdk');
var sdk = new PmpSdk({client_id: '1', client_secret: '2', host: 'https://api.pmp.io'});

sdk.fetchDoc('89944632-fe7c-47df-bc2c-b2036d823f98', (doc, resp) {
  console.log(resp.status);          // 200
  console.log(resp.success);         // true
  console.log(doc.attributes.guid);  // "89944632-fe7c-47df-bc2c-b2036d823f98"
  console.log(doc.attributes.title); // "Arts Topic"
});
```

```perl
my $client = Net::PMP::Client->new(id => '1', secret => '2', host => 'https://api.pmp.io');
my $doc = $client->get_doc_by_guid('89944632-fe7c-47df-bc2c-b2036d823f98');

print $doc->get_guid . "\n";  # "89944632-fe7c-47df-bc2c-b2036d823f98"
print $doc->get_title . "\n"; # "Arts Topic"
```

```php
<?php
$auth = new \Pmp\Sdk\AuthClient('https://api.pmp.io', 'myid', 'mysecret');
$home = new \Pmp\Sdk\CollectionDocJson('https://api.pmp.io', $auth);

$opts = array('guid' => '89944632-fe7c-47df-bc2c-b2036d823f98');
$doc = $home->query('urn:collectiondoc:hreftpl:docs')->submit($opts);

echo $doc->attributes->guid;  // "89944632-fe7c-47df-bc2c-b2036d823f98"
echo $doc->attributes->title; // "Arts Topic"
?>
```

```ruby
pmp = PMP::Client.new(client_id: '1', client_secret: '2', endpoint: 'https://api.pmp.io')
doc = pmp.query['urn:collectiondoc:hreftpl:docs'].where(guid: '89944632-fe7c-47df-bc2c-b2036d823f98')

puts doc.guid  # "04224975-e93c-4b17-9df9-96db37d318f3"
puts doc.title # "Arts Topic"
```

Alternately, we can fetch some documents by their "alias", rather than the guid.  For the "arts topic" document, we can fetch it via the **arts** alias, using the **topics** endpoint (see `urn:collectiondoc:hreftpl:topics` in [the home doc](https://api.pmp.io)).

```shell
curl -H "Authorization: Bearer 3f2401ae1a74adf8b14a638a" -X GET "https://api.pmp.io/topics/arts"

# returns a big collection+doc json string
```

```javascript
var PmpSdk = require('pmpsdk');
var sdk = new PmpSdk({client_id: '1', client_secret: '2', host: 'https://api.pmp.io'});

sdk.fetchTopic('arts', (doc, resp) {
  console.log(resp.status);          // 200
  console.log(resp.success);         // true
  console.log(doc.attributes.guid);  // "89944632-fe7c-47df-bc2c-b2036d823f98"
  console.log(doc.attributes.title); // "Arts Topic"
});
```

```perl
my $client = Net::PMP::Client->new(id => '1', secret => '2', host => 'https://api.pmp.io');
my $root   = $client->get_doc();
my $uri    = $root->query('urn:collectiondoc:hreftpl:topics')->as_uri( { guid => 'arts' } );

my $doc = $client->get_doc($uri);

print $doc->get_guid . "\n";  # "89944632-fe7c-47df-bc2c-b2036d823f98"
print $doc->get_title . "\n"; # "Arts Topic"
```

```php
<?php
$auth = new \Pmp\Sdk\AuthClient('https://api.pmp.io', 'myid', 'mysecret');
$home = new \Pmp\Sdk\CollectionDocJson('https://api.pmp.io', $auth);

$opts = array('guid' => 'arts');
$doc = $home->query('urn:collectiondoc:hreftpl:topics')->submit($opts);

echo $doc->attributes->guid;  // "89944632-fe7c-47df-bc2c-b2036d823f98"
echo $doc->attributes->title; // "Arts Topic"
?>
```

```ruby
pmp = PMP::Client.new(client_id: '1', client_secret: '2', endpoint: 'https://api.pmp.io')
doc = pmp.query['urn:collectiondoc:hreftpl:topics'].where(guid: 'arts')

puts doc.guid  # "04224975-e93c-4b17-9df9-96db37d318f3"
puts doc.title # "Arts Topic"
```


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
search = pmp.query['urn:collectiondoc:hreftpl:docs'].where(collection: '89944632-fe7c-47df-bc2c-b2036d823f98', profile: 'story')

if search && search.navigation && search.navigation[:self]
  puts "total = #{search.navigation[:self].totalitems}"
end
search.items.each do |item|
  puts "item = #{item.title} -> #{item.published}"
end
```

## Following links


## Searching the PMP


## Creating documents


## Updating documents


## Deleting documents

