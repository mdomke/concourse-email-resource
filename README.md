# Email Resource

A [Concourse CI](http://concourse.ci) resource to send emails.

## Source Configuration

* `from`: *Required*. The email address of the sender as a string.

### Example

Adding the resource to your project:

``` yaml
resource_types:
- name: email
  type: docker-image
  source:
    repository: mdomke/concourse-email-resource
```

Resource configuration:

``` yaml
resources:
- name: send-email
  type: email
  source:
    from: ci@example.com
```

Sending an email message:

``` yaml
- put: send-email
  params:
    to: recipient@example.com
    subject: subject.txt
    body: body.txt
```

## Behavior

`check` and `in` operations are a noop.

### `out`: Send an email message

#### Parameters

* `subject`: A path to the file holding the email subject.
* `body`: A path to the file holding the email body.

The `subject` will be prepended with the build-id in the form "Build #XX" and the
`body` will have a link to the build appended.
