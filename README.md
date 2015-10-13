# iCapps Translations

Import the translations from the iCapps translations portal.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'icapps-translations'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install icapps-translations

## Usage

- `translations init`: Run from your project root in order to setup the translations configuration.
- `translations import`: Run from your project root in order to import the translations into the matching _.strings_ files.

_You can pass the `--verbose` parameter to both commands in order to get more detailed information on what is happening._

### Xcode

The 'translations' gem currently supports the following folder structure for **iOS**:

`*/en.lproj/Localizable.strings`

In this case the language's short name is 'en' and the filename in the configuration is set to 'Localizable.strings'. The en.lproj folder can be nested inside other folders.

### Android

We currently check if the folder has an android project by looking for `.gradle` files. So this is currently the only supported way for Android.

The 'translations' gem currently supports the following folder structure for **Android**:

`app/src/main/res/values-en/strings.xml`

In this case the language's short name is 'en' and the filename in the configuration is set to 'strings.xml'. It's important that this structure is available as defined above. This is currently not configurable.

When you have a `default_language` set to 'en' in your configuration file the `values-en` will be `values` instead.

## Build gem

Start by updating the version number in the `lib/icapps/translations/version.rb` file.

Then build the gem by running the following commands:

    rake build
    rake release

## Contributing

1. Fork it ( https://github.com/icapps/translations/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Run `rubycop` in order to be compliant to our coding style.
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
