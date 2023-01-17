import pypylon.pylon as py
import os
import base64
from io import BytesIO
from PIL import Image

os.environ["PYLON_CAMEMU"] = "1"

cam = py.InstantCamera(py.TlFactory.GetInstance().CreateFirstDevice())
cam.Open()

cam.ImageFilename = "/usr/src/node-red/horse.png"

# enable image file test pattern
cam.ImageFileMode = "On"

# disable testpattern [ image file is "real-image"]
cam.TestImageSelector = "Off"

# choose one pixel format. camera emulation does conversion on the fly
cam.PixelFormat = "RGB8Packed"

cam.StartGrabbing()

while cam.IsGrabbing():
    res = cam.RetrieveResult(1000)
    pil_img = Image.fromarray(res.Array)
    res.Release()
    buff = BytesIO()
    pil_img.save(buff, format="JPEG")
    print(base64.b64encode(buff.getvalue()).decode("utf-8"))
    
cam.StopGrabbing()