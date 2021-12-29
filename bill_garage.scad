/*************************************************************************************
 *
 * Storage boxes.
 *
 *************************************************************************************
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHOR OR COPYRIGHT
 * HOLDER BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * IT IS NOT PERMITTED TO MODIFY THIS COMMENT BLOCK.
 *
 * (c)2019, Claude "Tryphon" Theroux, Montreal, Quebec, Canada
 * http://www.ctheroux.com/
 *
 ************************************************************************************/

box_tickness_in_mm = 2;
//box_tickness_in_mm = 1.5;

box_width_in_mm = 51 + 2*box_tickness_in_mm;
box_length_in_mm = 71 + 2*box_tickness_in_mm;
//box_height_in_mm = 31.5;
box_height_in_mm = 20;

lid_height_in_mm = 5;
//lid_tickness_in_mm = 1.5;
lid_tickness_in_mm = 2;
lid_tolerance_in_mm = 0.2;

make_box();

translate([60, 0, 0])
    make_cover();

// There is no parameters below this line

$fn = 60;

lid_width = box_width_in_mm - box_tickness_in_mm * 2 - lid_tolerance_in_mm;
lid_length = box_length_in_mm - box_tickness_in_mm * 2 - lid_tolerance_in_mm;
lid_offset = box_tickness_in_mm + (lid_tolerance_in_mm / 2);

module make_border_length()
{
    sphere(d = lid_tickness_in_mm);
    translate([0, lid_length - lid_tickness_in_mm, 0]) sphere(d = lid_tickness_in_mm);
    rotate([-90, 0, 0]) cylinder(d = lid_tickness_in_mm, h = lid_length - lid_tickness_in_mm);
}

module make_border_chamfer()
{
    make_border_length();
    translate([0, 0, lid_width - lid_tickness_in_mm]) make_border_length();
    cylinder(d = lid_tickness_in_mm, h = lid_width - lid_tickness_in_mm);
    translate([0, lid_length - lid_tickness_in_mm, 0]) cylinder(d = lid_tickness_in_mm, h = lid_width - lid_tickness_in_mm);
}

module make_cover_lid()
{
    cylinder(d = lid_tickness_in_mm, h = lid_height_in_mm);
    translate([lid_width - lid_tickness_in_mm, 0, 0]) cylinder(d = lid_tickness_in_mm, h = lid_height_in_mm);
    translate([0, lid_length - lid_tickness_in_mm, 0]) cylinder(d = lid_tickness_in_mm, h = lid_height_in_mm);
    translate([lid_width - lid_tickness_in_mm, lid_length - lid_tickness_in_mm, 0]) cylinder(d = lid_tickness_in_mm, h = lid_height_in_mm);
    
    translate([0, -lid_tickness_in_mm / 2, 0]) cube([lid_width - lid_tickness_in_mm, lid_tickness_in_mm,lid_height_in_mm]);
    translate([0, lid_length - lid_tickness_in_mm / 2 - lid_tickness_in_mm, 0]) cube([lid_width - lid_tickness_in_mm, lid_tickness_in_mm,lid_height_in_mm]);
    translate([-lid_tickness_in_mm / 2, 0, 0]) cube([lid_tickness_in_mm, lid_length - lid_tickness_in_mm, ,lid_height_in_mm]);
    translate([lid_width - lid_tickness_in_mm / 2 - lid_tickness_in_mm, 0, 0]) cube([lid_tickness_in_mm, lid_length - lid_tickness_in_mm, ,lid_height_in_mm]);
    
}

module make_cover()
{
    cube([box_width_in_mm, box_length_in_mm, box_tickness_in_mm]);
    translate([lid_offset + lid_tickness_in_mm / 2, lid_offset + lid_tickness_in_mm / 2 , 0]) make_cover_lid();
     translate([box_tickness_in_mm + lid_tickness_in_mm / 2 + lid_tolerance_in_mm / 2, box_tickness_in_mm + lid_tickness_in_mm / 2 + lid_tolerance_in_mm / 2, lid_height_in_mm]) rotate([0, 90, 0] ) make_border_chamfer();
}

module make_box()
{
    difference() {
        cube([box_width_in_mm, box_length_in_mm, box_height_in_mm]);
        translate([box_tickness_in_mm, box_tickness_in_mm, box_tickness_in_mm]) cube([box_width_in_mm - box_tickness_in_mm * 2, box_length_in_mm - box_tickness_in_mm * 2, box_height_in_mm - box_tickness_in_mm]);
        // Cutout for connectors
        translate([box_width_in_mm - box_tickness_in_mm, 12 + box_tickness_in_mm, 7 + box_tickness_in_mm]) cube([10, 55, 50]);
    }
    
    // Rim to keep pins off bottom and board level
    difference(){
        cube([box_width_in_mm, box_length_in_mm, 5 + box_tickness_in_mm ]);
        translate([2 + box_tickness_in_mm, 2 + box_tickness_in_mm, box_tickness_in_mm]) cube([box_width_in_mm - 2 * box_tickness_in_mm - 4, box_length_in_mm - 2 * box_tickness_in_mm - 4, 5]);
    }
}
