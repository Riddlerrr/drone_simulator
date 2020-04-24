# RC drone simulator

It's an example of implementations for [RC drone simulator problem](rc_drone_simulator_problem.md)

### How to run application:

```
ruby run.rb commands.txt
```

By default this command run all robot's commands from `commands.txt` file.
Please edit this file to change commands.

### How to test application:

You need to run `bundle` to install RSpec:
```
bundle install
```

After that you can run tests:
```
rspec
```
