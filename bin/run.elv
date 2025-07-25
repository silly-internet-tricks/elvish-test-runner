# NOTES:

# first step, is to import the tests
# the test path should be passed in as an arg
# (probably the only arg, I'm thinking)

# now, I will copy the test file to a hardcoded location
# so that it can be used as a module

cp $args[0].test.elv ./test.elv
cp $args[0].elv ./solution.elv
use ./test
var tests = (test:tests)

var tests-run = (num 0)
var tests-passed = (num 0)
var tests-failed = (num 0)
var tests-errored = (num 0)



# This file will produce a JSON output, that matches the spec here:
#     https://exercism.org/docs/building/tooling/test-runners/interface
# (atm, I am thinking of just printing the file line by line)
# the first two lines:
# {
#   "version": 2,
# then on the third line, we need to fill in the status with pass, fail or error
#   "status": "pass|fail|error",
# on line four, the message needs to be filled in if the status is error
# line four can be omitted otherwise
# the next two lines are:
#   "tests": [
#     {


# {
#   "version": 2,
#   "status": "fail",
#   "message": null,
#   "tests": [
#     {
#       "name": "Test that the thing works",
#       "status": "fail",
#       "message": "Expected 42 but got 123123",
#       "output": "Debugging information output by the user",
#       "test_code": "assert_equal 42, answerToTheUltimateQuestion()"
#     }
#   ]
# }
