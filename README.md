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

* `to`: _(mandatory)_ A list of recipients as strings.
* `subject`: _(mandatory)_ A path to the file holding the email subject.
* `body`: _(mandatory)_ A path to the file holding the email body.
* `vars`: _(optional)_ A path to a JSON-file holding template vars.
* `type`: _(optional)_ The MIME subtype (defaults to `"html"`)

`subject` and `body` can both either be plain text, html or a [jinja](http://jinja.pocoo.org/docs/dev/)-template.
In the latter case you can specify an additional file (`vars`) for holding template variables that should
be rendered into the template. Additionally to the variables from the `vars`-file, all environment variables can
be used in the template.

A more elaborate usage example would look like this:

```yaml
- put: send-email
  params:
    to: recipient@example.com
    subject: subject
    body: body.html
    vars: vars.json
    type: html
```

