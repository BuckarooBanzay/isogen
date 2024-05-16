package main

import (
	"bytes"
	"fmt"
	"image/color"
	"image/png"
	"os"
)

func NewPalette(imagefile []byte) ([]*color.RGBA, error) {
	palette := []*color.RGBA{}

	reader := bytes.NewReader(imagefile)
	img, err := png.Decode(reader)

	if err != nil {
		return nil, err
	}

	bounds := img.Bounds()
	for y := bounds.Min.Y; y < bounds.Max.Y; y++ {
		for x := bounds.Min.X; x < bounds.Max.X; x++ {
			c := img.At(x, y)
			r, g, b, a := c.RGBA()
			palette = append(palette, &color.RGBA{uint8(r), uint8(g), uint8(b), uint8(a)})
		}
	}

	return palette, nil
}

func main() {
	if len(os.Args) != 2 {
		fmt.Println("Usage: ./palette_json <filename>")
		return
	}
	filename := os.Args[1]

	data, err := os.ReadFile(filename)
	if err != nil {
		panic(err)
	}

	p, err := NewPalette(data)
	if err != nil {
		panic(err)
	}

	fmt.Println("[")
	for i, c := range p {
		fmt.Printf(`	{"r":%d,"g":%d,"b":%d,"a":%d}`, c.R, c.G, c.B, c.A)
		if i < len(p)-1 {
			fmt.Print(",")
		}
		fmt.Println()
	}
	fmt.Println("]")

}
