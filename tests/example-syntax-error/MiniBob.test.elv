use ./solution

# I am imagining just exporting one function,
# which itself returns a list of all the test functions


# each function in the list of test functions will output:
#   the actual value after running the solution
#   the expected value
#   (output as a map for convenience)
fn tests {
  put [
    {
      put [
        &name="stating something"
        &actual=(solution:hey "Tom-ay-to, tom-aaaah-to.")
        &expected="Whatever."
      ]
    }
    {
      put [
        &name="shouting"
        &actual=(solution:hey "WATCH OUT!")
        &expected="Whoa, chill out!"
      ]
    }
  ]
}
