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
    to: [recipient@example.com]
    subject: subject.txt
    body: body.txt
```

## Behavior

`check` and `in` operations are a noop.

### `out`: Send an email message

#### Parameters

* `to|to_file`: _(mandatory)_ Use `to` to specify a list of recipients as strings or use `to_file` to specify file with addresses, each address should be in a new line.
* `subject|subject_text`: _(mandatory)_ Use `subject` to specify a path to the file holding the email subject or use `subject_text` to specify a plain text subject.
* `body|body_text`: _(mandatory)_ Use `body ` to specify a path to the file holding the email body or use `body_text` to specify a plain text email body.
* `vars`: _(optional)_ A path to a JSON-file holding template vars.
* `type`: _(optional)_ The MIME subtype (defaults to `"html"`)
* `inline_css`: _(optional)_ Inline CSS to style attributes in HTML.
* `attachments`: A list of file names that will be attached to the email. Attachments only work if `type` is `"html"`.

`subject|subject_text` and `body|body_text` can both either be plain text, html or a [jinja](http://jinja.pocoo.org/docs/dev/)-template.
In the latter case you can specify an additional file (`vars`) for holding template variables that should
be rendered into the template. Additionally to the variables from the `vars`-file, all environment variables can
be used in the template (e.g.: ``BUILD_ID``). By default (if the MIME subtype is "html"), the CSS styles will be
inlined to the HTML. If you don't want that, you can set the `inline_css` parameter to `False`.
If you want to use jinja-template in `subject_text` or `body_text` you need to define the content as a multiline text, otherwise a syntax error will be reported for malformed yaml.

``` yaml
- put: send-email
  params:
    to: [recipient@example.com]
    subject_text: |
      {% block BUILD_PIPELINE_NAME %}{% endblock %}:{% block BUILD_JOB_NAME %}{% endblock %} failed
    body_text: |
      {% block BUILD_PIPELINE_NAME %}{% endblock %}:{% block BUILD_JOB_NAME %}{% endblock %} failed
```

A more elaborate usage example would look like this:

```yaml
- put: send-email
  params:
    to: [recipient@example.com]
    subject: subject
    body: body.html
    vars: vars.json
```

or for a plain text example:

```yaml
- put: send-email
  params:
    to: [recipient@example.com]
    subject: subject.txt
    body: body.txt
    type: plain
```

