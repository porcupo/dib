require 'dib'

DIB.start(['rc', 'web', 'v0.8.1'])

describe DIB, "#start" do
  it "returns next rc tag for version v0.8.1" do
    args = ['rc', 'web', 'v0.8.1']
    tag = DIB.start(args)
    expect(tag).to eq ('rc/0.8.1-6')
  end
  it "returns next rc tag for version v0.8.0" do
    args = ['rc', 'web', 'v0.8.0']
    tag = DIB.start(args)
    expect(tag).to eq ('rc/0.8.0-13')
  end
end
