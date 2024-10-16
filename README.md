# Story Teller 3D Book [![Made with Godot](https://img.shields.io/badge/Made%20with-Godot-478CBF?style=flat&logo=godot%20engine&logoColor=white)](https://godotengine.org)
Forked from [Interactive 3D book](https://github.com/miskatonicstudio/interactive-book-godot) for Godot 4.x

![Story Teller Screenshot](story-teller.gif)



A simple 3D book with animated, turnable pages that dynamically displays 2D scene content. The package includes a working Godot Engine project and the original Blender file featuring the animated page.
How to Use

Turn the pages using the left and right arrow keys. The content is generated dynamically as you flip through the book.
How It Works

This project generates page content using a 2D scene, which is converted into a texture by wrapping it in a Viewport node. There are six viewports in total:

	The current page (on the left)
	The next page (on the right)
	Two pages before the current one
	Two pages after the next one

These viewports ensure smooth transitions as you turn the pages. At any given time, a maximum of four pages are visible, but the additional two viewports help keep the logic consistent when animating.

The setup includes two Spatial nodes:

	One with two static pages (left and right)
	Another with four animated pages (left, middle front, middle back, right) visible during page turns.

During the animation, the static pages are hidden, and the animated ones are shown. Once the animation is complete, the static pages return and the animated ones are hidden.

Explore the code to see how it works, and feel free to test it yourself. If you have any questions, don't hesitate to reach out!

Font: Sniglet
Licensed under the SIL Open Font License, Version 1.1.
