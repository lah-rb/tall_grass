## How to contribute to tall_grass

#### **Did you find a bug?**

* **Ensure the bug was not already reported** by searching on GitHub under [Issues](https://github.com/lah-rb/tall_grass/issues)

* If you're unable to find an open issue addressing the problem, [open a new one](https://github.com/lah-rb/tall_grass/issues/new). Be sure to include a **title and clear description**, as much relevant information as possible, and a **code sample** or an **executable test case** demonstrating the expected behavior that is not occurring.

* The public debugging process is in itself a work in progress. If you have an idea on how to better implement the process please contact me. †

#### **Did you write a patch that fixes a bug?**

* Open a new GitHub pull request with the patch.

* Ensure the PR description clearly describes the problem and solution. Include the relevant issue number if applicable.

#### **Did you fix whitespace, format code, or make a purely cosmetic patch?**

Refactored changes that are cosmetic in nature and do not add anything substantial to the stability, functionality, or testability of tall_grass may be considered if the refactor is considered by the leadership to be more in line with the 'Ruby way'. These requests are more likely to be approved if documentation from a relevant source is provided i.e. according to [The Well Grounded Rubyist](https://www.manning.com/books/the-well-grounded-rubyist) ruby is known for being a consice language and thus tall_grass should implement the following refactor:

'case num'
'when 1'
'  puts num'
'when 2'
'  puts num'
'else'
'  exit'
'end'

to

'case num'
'when 1, 2'
'  puts num'
'else'
'  exit'
'end'

 These requests are more likely to be denied if the code changed has many dependents.

#### **Do you intend to add a new feature or change an existing one?**

* Suggest your change on GitHub and start writing code!

* Do not open an issue on GitHub until you have collected positive feedback about the change. GitHub issues are primarily intended for bug reports and fixes.

#### **Do you have questions about the source code?**

* Ask any question about how to use tall_grass †

#### **Do you want to contribute to the documentation?**

* Please do! Change the documentation and issue a pull request as per usual.

† tall_grass is currently a one man show, but if you have great ideas for the project please contact me through GitHub or by email at luke.a.hayes@outlook.com

Thanks!
