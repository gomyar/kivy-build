
# This file is used to perform one dummy p4a build to pull down
# all the dependencies during the docker build

import kivy
kivy.require('1.0.6') # replace with your current kivy version !

from kivy.app import App
from kivy.uix.label import Label

print "P4A_ORIENTATION: %s" % os.getenv('P4A_ORIENTATION', 'None')

class MyApp(App):

    def build(self):
        return Label(text='Hello world')


if __name__ == '__main__':
    MyApp().run()
