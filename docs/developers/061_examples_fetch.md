## Fetching documents

One of the basic PMP usages is fetching a single document.  For instance, let's fetch the "arts topic" document, with a GUID of `89944632-fe7c-47df-bc2c-b2036d823f98`...

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
$sdk = new \Pmp\Sdk('https://api.pmp.io', 'myid', 'mysecret');
$doc = $sdk->fetchDoc('89944632-fe7c-47df-bc2c-b2036d823f98');

if ($doc) {
    echo "{$doc->attributes->guid}\n";  // "89944632-fe7c-47df-bc2c-b2036d823f98"
    echo "{$doc->attributes->title}\n"; // "Arts Topic"
}
else {
    echo "failed to fetch the ARTS topic - must have been a 403 or 404.\n";
}
?>
```

```ruby
pmp = PMP::Client.new(client_id: '1', client_secret: '2', endpoint: 'https://api.pmp.io')
doc = pmp.query['urn:collectiondoc:hreftpl:docs'].where(guid: '89944632-fe7c-47df-bc2c-b2036d823f98')

puts doc.guid  # "04224975-e93c-4b17-9df9-96db37d318f3"
puts doc.title # "Arts Topic"
```

Alternatively, we can fetch some documents by their "alias", rather than the GUID.  For the "arts topic" document, we can fetch it via the **arts** alias, using the **topics** endpoint (see `urn:collectiondoc:hreftpl:topics` in [the home doc](https://api.pmp.io)).

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
$sdk = new \Pmp\Sdk('https://api.pmp.io', 'myid', 'mysecret');
$doc = $sdk->fetchTopic('arts');

if ($doc) {
    echo "{$doc->attributes->guid}\n";  // "89944632-fe7c-47df-bc2c-b2036d823f98"
    echo "{$doc->attributes->title}\n"; // "Arts Topic"
}
else {
    echo "failed to fetch the ARTS topic - must have been a 403 or 404.\n";
}
?>
```

```ruby
pmp = PMP::Client.new(client_id: '1', client_secret: '2', endpoint: 'https://api.pmp.io')
doc = pmp.query['urn:collectiondoc:hreftpl:topics'].where(guid: 'arts')

puts doc.guid  # "04224975-e93c-4b17-9df9-96db37d318f3"
puts doc.title # "Arts Topic"
```
