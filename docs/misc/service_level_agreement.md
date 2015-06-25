### Public Media Platform, Inc.

# API Service Level Agreement

This PMP API Service Level Agreement (“SLA”) governs the minimal guarantees offered to PMP API users under the PMP Terms of Use (“TOU”).  This SLA applies separately to each account using the PMP API.  The PMP reserves the right to change the terms of this SLA in accordance with the Terms of Use.

This document outlines the minimal performance you are guaranteed from the PMP.  In practice, you can expect much higher performance.  Average response time for read requests are generally under 40ms, full-text searches under 100ms, writes under 200ms, and uptime has been 100% due to the fully-redundant and multi-datacenter architecture of the PMP.

## Availability Guarantee

The PMP guarantees its API services will be available no less than 99.9% during a given calendar month.  This includes both read (api.pmp.io) and write (publish.pmp.io) endpoints.  The API will be considered unavailable when web traffic cannot contact the servers for a period of 5 consecutive minutes.

## Response Time Guarantee

The PMP guarantees its API read and write requests will be processed in a timely fashion.  Any single read request taking longer than 200 milliseconds, or a write request taking longer than 1000 milliseconds, shall be considered a response time failure for a period of 5 consecutive minutes.  Requests for greater-than-default page sizes may take slightly longer for each additional result.  Full-text PMP searches may also exceed the guaranteed read time, depending on the complexity of the search.

Response times are measured on the PMP API servers, and do not include any Internet latency between your servers and the API.

## Server Monitoring

The PMP will employ third party monitoring services (currently NewRelic.com) to assess the availability and performance of the PMP API.  These independent statistics will be used to compute the collective server uptime and downtime of the API.  Reports from these services are available at [status.pmp.io](http://status.pmp.io).

## Exclusions

The availability and response time guarantees outlined above do not apply to any PMP performance issues:

> **1.** arising from the suspension of your PMP account (due to violations of our Terms of Use, or other reasons);

> **2.** caused by factors outside of our reasonable control, including any force majeure event or Internet access or related problems beyond the demarcation point of the PMP API or its direct hosting subcontractors (i.e., beyond the point in the network where the PMP maintains access and control over the PMP API Services);

> **3.** that result from any action or inaction of you or any third party (other than the PMP’s direct hosting subcontractors);

> **4.** that result from your equipment, software or other technology and/or third party equipment, software or other technology (other than third party equipment within our direct control);

> **5.** that result from errors or failures within clients that interface with PMP API; or

> **6.** are due to scheduled maintenance, which the PMP has notified you of at least 5 days in advance via status.pmp.io.

## Remediation

If the PMP fails to meet the availability and response time guarantees outlined above, the PMP staff will be immediately notified by our server monitoring utilities, and will make a best effort to correct the issues as soon as possible.  As the PMP API is a free service, we are not able to provide any service credits or other financial compensation at this time.

## Shutdown Guarantee

The PMP, or one of its founding partners, is contractually obligated to maintain its API services until at least August 2020.  If the PMP is deemed unsustainable, and services will be shut down, it will give all API users at least 12 months notice to transition onto other platforms.  It will also provide all API users with a file archive of all their PMP content at the time of shutdown.
