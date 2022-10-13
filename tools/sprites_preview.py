import os

import PIL
from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw 


BASE = ''
SOURCE = 'mask_3_loaded.bin'
TARGET = 'mask3_decoded_.png'
ADR = 24576


IMAGE_WIDTH = 700+300-20
IMAGE_HEIGHT = 500+100

FONTNAME = 'arial.ttf'
FONTNAME = 'consola.ttf'
FONTSIZE = 9

class zxbin(object):
    '''
    classdocs
    '''

    def __init__(self, filename, offset):
        '''
        Constructor
        '''

        self.raw = open(filename, "rb").read()
        self.offset = offset

        # CL_BLK EQU 0    ; black        000
        # CL_BLU EQU 1    ; blue        001
        # CL_RED EQU 2    ; red        010
        # CL_MGN EQU 3    ; magenta    011
        # CL_GRN EQU 4    ; green        100
        # CL_SKY EQU 5    ; skyblue    101
        # CL_YEL EQU 6    ; yellow    110
        # CL_WHT EQU 7    ; white        111

        self.BRIGHT = {
            0: (0,0,0),          # CL_BLK
            1: (0,0,255),        # CL_BLU
            2: (255,0,0),        # CL_RED
            3: (255,0,255),      # CL_MGN
            4: (0,255,0),        # CL_GRN
            5: (0,255,255),      # CL_SKY
            6: (255,255,0),      # CL_YEL
            7: (255,255,255),    # CL_WHT
        }
        
        self.REGULAR = {
            0: (0,0,0),          # CL_BLK
            1: (0,0,215),        # CL_BLU
            2: (215,0,0),        # CL_RED
            3: (215,0,215),      # CL_MGN
            4: (0,215,0),        # CL_GRN
            5: (0,215,215),      # CL_SKY
            6: (215,215,0),      # CL_YEL
            7: (215,215,215),    # CL_WHT
        }

        self.set_ink(0)
        self.set_paper(7)
        self.reset_bright()
        

    def __enter__(self):
        return self


    def __exit__(self, exception_type, exception_value, traceback):
        try:
            pass
        except Exception as error:
            print('Error closing')
            raise error
        
    def get_byte(self, adr):
        try:
            return self.raw[adr - self.offset]
        except Exception as error:
            print('adr=', adr, 'offset=', self.offset)
            raise error

    def set_ink(self, index):
        self.ink = index
         
    def set_paper(self, index):
        self.paper = index
        
    def set_bright(self):
        self.brightness = True
        self.colors = self.BRIGHT
    
    def reset_bright(self):
        self.brightness = False
        self.colors = self.REGULAR

    def byte_to_colors(self, source):
        result = []
        for bit in format(source, '08b'):
            if bit == '0':
                result.append(self.colors[self.paper])
            else: 
                result.append(self.colors[self.ink])
            
        return result
    

    def set_color(self, source):
        b = format(source, '08b')
        _flash = b[0]
        bright = int(b[1], 2)
        paper = int(b[2:5], 2)
        ink = int(b[5:8], 2)
        
        self.set_ink(ink)
        self.set_paper(paper)
        
        if bright:
            self.set_bright()
        else:
            self.reset_bright()


with zxbin(BASE+SOURCE, ADR) as venom:
    venom.set_color(7)

    with Image.new('RGB', (IMAGE_WIDTH, IMAGE_HEIGHT), color=(128,128,128,0)) as new_im:
        fonts_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'fonts')
        font = ImageFont.truetype(os.path.join(fonts_path, FONTNAME), FONTSIZE)
        draw = ImageDraw.Draw(new_im)

        # ------------------------                
        sprites = [
            {'adr': 52576, 'count': 10, 'w': 4, 'h': 4, 'x': 5, 'y': 1},        # player

            {'adr': 53856, 'count': 4, 'w': 2, 'h': 2, 'x': 100+30, 'y': 1},       # balls
            {'adr': 53984, 'count': 4, 'w': 3, 'h': 2, 'x': 100+30, 'y': 85},      # rocket
            {'adr': 54176, 'count': 1, 'w': 10, 'h': 2, 'x': 100+30, 'y': 170},    # big digits
            {'adr': 54336, 'count': 1, 'w': 8, 'h': 2, 'x': 100+30, 'y': 200},     # circle
            {'adr': 54464, 'count': 1, 'w': 12, 'h': 2, 'x': 100+30, 'y': 230},   # explosion
            {'adr': 54656, 'count': 1, 'w': 22, 'h': 2, 'x': 100+30, 'y': 260},   # weapons
            {'adr': 55008, 'count': 2, 'w': 12, 'h': 2, 'x': 100+30, 'y': 290},   # bullets
            {'adr': 55392, 'count': 1, 'w': 8, 'h': 1, 'x': 100+30, 'y': 340},   # bullets
            {'adr': 55456, 'count': 1, 'w': 12, 'h': 2, 'x': 100+30, 'y': 355},   # jumper
            {'adr': 55648, 'count': 1, 'w': 8, 'h': 2, 'x': 100+30, 'y': 380},   # r2d2
            ###
            #{'adr': 55776, 'count': 2, 'w': 4, 'h': 2, 'x': 100, 'y': 400},   #
            ###
            {'adr': 56256, 'count': 1, 'w': 4, 'h': 4, 'x': 100+30, 'y': 430},     # bomb
            
            {'adr': 56384, 'count': 1, 'w': 24, 'h': 3, 'x': 100+30, 'y': 470},    #

            {'adr': 56960, 'count': 1, 'w': 6, 'h': 2, 'x': 300+30, 'y': 1},       #

            {'adr': 57056, 'count': 1, 'w': 4, 'h': 4, 'x': 300+30, 'y': 30},      # cannon
            {'adr': 57184, 'count': 5, 'w': 2, 'h': 2, 'x': 300+30, 'y': 70},      # bullet


            {'adr': 57344, 'count': 8, 'w': 16*2, 'h': 1, 'x': 300+170, 'y': 170-150-19, 'gap': 10},      # grass

            #{'adr': 59392, 'count': 5, 'w': 15, 'h': 3, 'x': 300, 'y': 300},      # grass

            {'adr': 24576, 'count': 3, 'w': 16*2, 'h': 1, 'x': 300+170, 'y': 350-150-19, 'gap': 10},      # grass
            #{'adr': 24576, 'count': 2, 'w': 16*2, 'h': 1, 'x': 300, 'y': 300},      # grass

            {'adr': 25600+8, 'count': 6, 'w': 4, 'h': 1, 'x': 300+150-300-150, 'y': 250+120, 'gap': 10},      # grass

            #{'adr': 25856, 'count': 1, 'w': 1, 'h': 1, 'x': 600, 'y': 250, 'gap': 10},      # grass
            #{'adr': 25856+7, 'count': 1, 'w': 16, 'h': 1, 'x': 600, 'y': 250+20, 'gap': 10},      # grass

            {'adr': 26032, 'count': 1, 'w': 10, 'h': 1, 'x': 600-180, 'y': 250, 'gap': 10},      # grass

            {'adr': 26112, 'count': 3+9, 'w': 16, 'h': 1, 'x': 600-180, 'y': 250+20, 'gap': 8},      # grass

            {'adr': 27904, 'count': 8, 'w': 32, 'h': 1, 'x': 600+40, 'y': 250-5, 'gap': 8},      # grass

            {'adr': 61440, 'count': 2, 'w': 32, 'h': 1, 'x': 600+40, 'y': 430-25-5, 'gap': 8},      # grass

            {'adr': 62272, 'count': 1, 'w': 32-8, 'h': 1, 'x': 600+40, 'y': 430+50-25-10, 'gap': 8},      # grass
            {'adr': 62272+32*8-8*8, 'count': 1, 'w': 32, 'h': 1, 'x': 600+40, 'y': 430+50-25-10+18, 'gap': 8},      # grass

            {'adr': 62976, 'count': 6, 'w': 32, 'h': 1, 'x': 600+40, 'y': 430+50+20-15+5, 'gap': 8},      # grass
        ]
        
        for sprite in sprites:
            x = sprite['x']
            y = sprite['y']
            h = sprite['h']
            w = sprite['w']
            adr = sprite['adr']

            gap = sprite.get('gap', 0)
            
            for num in range(sprite['count']):
                txt_1 = '{}: {} / {}'.format(num, adr, format(adr, '02x'))
                txt_x = x+8+w*8
                txt_y = y-1

                draw.text((txt_x, txt_y), txt_1, (255,255,255), font=font)
    
                for curr_w in range(w):
                    for curr_h in range(h):
                        for src_addr in range(adr, adr+8):
                            data = venom.byte_to_colors(venom.get_byte(src_addr))
                            
                            for inx, clr in enumerate(data):
                                try:
                                    new_im.putpixel((x+inx, y), clr)
                                except Exception as error:
                                    print("Image width: {}, pixel: {}".format(IMAGE_WIDTH, x+inx))
                                    print("Image height: {}, pixel: {}".format(IMAGE_HEIGHT, y))
                                    raise error
                            
                            y += 1
            
                        adr += 8
                    y -= h*8
                    x += 8
                
                x -= w*8
                y += h*8
                y += (3 + gap)
        
                txt_2 = '{} / {}'.format(adr-1, format(adr-1, '02x'))
                draw.text((txt_x+16, txt_y+8), txt_2, (240,240,240), font=font)

#                 for curr_h in range(h):
#                     for curr_w in range(w):
#                         for src_addr in range(adr, adr+8):
#                             data = venom.byte_to_colors(venom.get_byte(src_addr))
#                             
#                             for inx, clr in enumerate(data):
#                                 new_im.putpixel((x+inx+curr_w*8, y+curr_h*8), clr)
#                             
#                             y += 1
#             
#                         adr += 8
        # ------------------------                

             




                
        new_im.show()
        new_im.save(TARGET)
        print('Saved "{}"'.format(TARGET))
