# backup-cookbook-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['backup-cookbook']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### backup-cookbook::default

Include `backup-cookbook` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[backup-cookbook::default]"
  ]
}
```

## License and Authors

Author:: YOUR_NAME (<YOUR_EMAIL>)
