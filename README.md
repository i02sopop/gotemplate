# Gotemplate
This repo is a template to start a new go project. The binary generated only shows a hello world message, but it have the enough infrastucture and code to start a go project and run the tests.

# How to use it

Both to build and to test the project I make use of docker, using the `golang:1.7-alpine` image, that will be downloaded the first time tou build the project or run the tests, so you need docker permissions to work with the project. To build the *gotemplate* command run:

```
make
```

and it will generate the binary in `bin/arch/gotemplate`, being arch your computer architecture. To run the tests you should run:

```
make tests
```

and it will show the tests results on the terminal.

# License
Gotemplate is licensed under the [GNU GPLv3](https://www.gnu.org/licenses/gpl.html). You should have received a copy of the GNU General Public License along with Gotemplate. If not, see http://www.gnu.org/licenses/.

<p align="center">
<img src="https://www.gnu.org/graphics/gplv3-127x51.png" alt="GNU GPLv3">
</p>
