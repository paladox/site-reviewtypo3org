source "http://chef.typo3.org:26200"
source "https://supermarket.chef.io"

solver :ruby, :required

metadata

def fixture(name)
  cookbook name, path: "test/fixtures/cookbooks/#{name}"
end

group :integration do
  cookbook 'apt'
  fixture 'site-reviewtypo3org_test'
end
