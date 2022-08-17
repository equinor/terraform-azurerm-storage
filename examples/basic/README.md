# Basic Example

Terraform configuration which creates an Azure Storage account with the following features:

- Read-access geo-redundant storage (RA-GRS)
- Secure transfer (HTTPS) required
- Shared key authorization disabled
- Anonymous public read access to containers and blobs disabled
- Firewall rules enabled
- Soft delete for blobs enabled
- Soft delete for containers enabled
- Blob versioning enabled
- Blob change feed enabled
- Point-in-time restore for block blobs enabled
- Advanced threat protection enabled
- Diagnostic settings for blob, queue, table and file storage
- Storage object replication
