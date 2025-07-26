use str

fn hey {|query|
    if (str:has-prefix $query "T") {
      put "Whatever."
    } else {
      put "Whoa, chill out!"
    }
}
