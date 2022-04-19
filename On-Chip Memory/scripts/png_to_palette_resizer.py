from PIL import Image
from collections import Counter
from scipy.spatial import KDTree
import numpy as np
def hex_to_rgb(num):
    h = str(num)
    return int(h[0:4], 16), int(('0x' + h[4:6]), 16), int(('0x' + h[6:8]), 16)
def rgb_to_hex(num):
    h = str(num)
    return int(h[0:4], 16), int(('0x' + h[4:6]), 16), int(('0x' + h[6:8]), 16)
filename = input("What's the image name? ")
new_w, new_h = map(int, input("What's the new height x width? Like 28 28. ").split(' '))
# bricks palette
# palette_hex = ['0x0D1000', '0x252108', '0x2F2013', '0x3D210E', '0x5B301B', '0x6E381C', '0x8F4D2A', '0x8A4D21', '0xCB6C3D', '0xB46E27', '0xD88E46', '0xFE06FF', '0xB27721']

# mario palette
# palette_hex = ['0xFFD5CF', '0x2d1e10', '0x420000', '0x570000','0x2d1e10' '0xE4312F', '0xFF7B68', '0xa96f3f', '0xD9D36F', '0xCFB4B5', '0xA11F28', '0xFE06FF', '0x734b2a', '0x1c4d6c', '0x2871a2', '0x000057']

# background palette 
palette_hex = ['0x57b8fa', '0x01030a', '0xffffff', '0x002fa2', '0xcc8a5e', '0x518425', '0x426823', '0x5b9c20', '0xcc8a5e', '0x9e5636', '0x91563b', '0x6c3b37', '0xe1dfdc', '0x94ce51']

palette_rgb = [hex_to_rgb(color) for color in palette_hex]

pixel_tree = KDTree(palette_rgb)
im = Image.open("./sprite_originals/" + filename+ ".png") #Can be many different formats.
im = im.convert("RGBA")
layer = Image.new('RGBA',(new_w, new_h), (0,0,0,0))
layer.paste(im, (0, 0))
im = layer
#im = im.resize((new_w, new_h),Image.ANTIALIAS) # regular resize
pix = im.load()
pix_freqs = Counter([pix[x, y] for x in range(im.size[0]) for y in range(im.size[1])])
pix_freqs_sorted = sorted(pix_freqs.items(), key=lambda x: x[1])
pix_freqs_sorted.reverse()
print(pix)
outImg = Image.new('RGB', im.size, color='white')
outFile = open("./sprite_bytes/" + filename + '.txt', 'w')
i = 0
for y in range(im.size[1]):
    for x in range(im.size[0]):
        pixel = im.getpixel((x,y))
        print(pixel)
        if(pixel[3] < 200):
            outImg.putpixel((x,y), palette_rgb[0])
            outFile.write("%x\n" %(0))
            print(i)
        else:
            index = pixel_tree.query(pixel[:3])[1]
            outImg.putpixel((x,y), palette_rgb[index])
            outFile.write("%x\n" %(index))
        i += 1
outFile.close()
outImg.save("./sprite_converted/" + filename + ".png" )
