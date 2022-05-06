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
# palette_hex = ['0xFFD5CF', '0x2d1e10', '0x420000', '0x570000', '0xE4312F', '0xFF7B68', '0xa96f3f', '0xD9D36F', '0xCFB4B5', '0xA11F28', '0xFE06FF', '0x734b2a', '0x1c4d6c', '0x2871a2', '0x000057']

# background palette 
palette_hex = ['0x57b8fa', '0x01030a', '0xffffff', '0x002fa2', '0xcc8a5e', '0x518425', '0x426823', '0x5b9c20', '0xcc8a5e', '0x9e5636', '0x91563b', '0x6c3b37', '0xe1dfdc', '0x94ce51']

# coin palette
# palette_hex = ['0xfe06ff', '0xfefefe', '0xfbfbfb', '0x7f7f7f', '0x2a2a2a', '0x0b0b0b', '0xc8c8c8', '0xfff100', '0xfbd705', '0xfddd03', '0xfbe87f', '0x141414']

# pipe palette
# palette_hex = ['0x023701', '0x075004', '0x116910', '0x208a1b', '0x41c23a', '0x66ee6a', '0x4bd844', '0x6cee71', '0x0e620d', '0x4dda49', '0xfe06ff']

# small pipe
# palette_hex = ['0x00b00b', '0x00d911', '0x00c00d', '0x2f5a31', '0x007d00', '0x009107', '0x00c50e', '0x00a006', '0xfe06ff']

# gooomba palette
# palette_hex = ['0xad6541', '0x0f061d', '0xf4f7f9', '0xccd1d5', '0x33251d', '0x4d480a', '0x745e3a', '0x2d2223', '0x91835a', '0x352824', '0xfe06ff']

# goomba 2 30x30 palette
# palette_hex = ['0x371b30' , '0xffffff', '0x714e32', '0x4e392c', '0x6b5336', '0x372923', '0x756149', '0xd3d7da', 
#                '0xad683f', '0xf2f3f3', '0x7b492e', '0x35383b', '0x6b402a']

#startscreen palette 640x480
palette_hex = ['0xfffd45', '0x000000', '0x0049a9', '0x5ce2e7', '0xe50607' ]

#00a500, 007a00, 005100, '000000', 0xffffff, 0x005800, 0xb2b0b3, ff2a2d, b20000, 880000 , fc7e00, ff7318, dc5000, ccb900, a1a43f, 7d7e7d
#palette hex for new yoshi?
# palette_hex = ['0x00a500', '0x007a00', '0x005100', '0x000000', '0xffffff', '0xb2b0b3', '0xff2a2d', '0xb20000', '0x880000' , '0xfc7e00', '0xff7318', '0xdc5000', '0xccb900', '0xa1a43f', '0x7d7e7d', '0xfe06ff']

#color palette for score
#d20303, f6fb00, dfa400, fde395, d4002e, d32a03, d64100
# palette_hex = ['0xd20303', '0xf6fb00', '0xdfa400', '0xfde395', '0xd4002e', '0xd32a03', '0xd64100', '0xfe06ff']

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
