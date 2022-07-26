# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `ttfunk` gem.
# Please instead update this file by running `bin/tapioca sync`.

# typed: true

module TTFunk; end

class TTFunk::Aggregate
  private

  def coerce(other); end
end

module TTFunk::BinUtils
  extend ::TTFunk::BinUtils

  def rangify(values); end
  def slice_int(value, bit_width:, slice_count:); end
  def stitch_int(arr, bit_width:); end
  def twos_comp_to_int(num, bit_width:); end
end

class TTFunk::BitField
  def initialize(value = T.unsafe(nil)); end

  def dup; end
  def off(pos); end
  def off?(pos); end
  def on(pos); end
  def on?(pos); end
  def value; end
end

class TTFunk::Collection
  include ::Enumerable

  def initialize(io); end

  def [](index); end
  def count; end
  def each; end

  class << self
    def open(path); end
  end
end

class TTFunk::Directory
  def initialize(io, offset = T.unsafe(nil)); end

  def scaler_type; end
  def tables; end
end

class TTFunk::DuplicatePlaceholderError < ::StandardError; end

class TTFunk::EncodedString
  def initialize; end

  def <<(obj); end
  def align!(width = T.unsafe(nil)); end
  def bytes; end
  def length; end
  def placeholders; end
  def resolve_placeholder(name, value); end
  def string; end
  def unresolved_string; end

  private

  def add_placeholder(new_placeholder, pos = T.unsafe(nil)); end
  def io; end
end

class TTFunk::Error < ::StandardError; end

class TTFunk::File
  def initialize(contents, offset = T.unsafe(nil)); end

  def ascent; end
  def bbox; end
  def cff; end
  def cmap; end
  def contents; end
  def descent; end
  def digital_signature; end
  def directory; end
  def directory_info(tag); end
  def find_glyph(glyph_id); end
  def glyph_locations; end
  def glyph_outlines; end
  def header; end
  def horizontal_header; end
  def horizontal_metrics; end
  def kerning; end
  def line_gap; end
  def maximum_profile; end
  def name; end
  def os2; end
  def postscript; end
  def sbix; end
  def vertical_origins; end

  class << self
    def from_dfont(file, which = T.unsafe(nil)); end
    def from_ttc(file, which = T.unsafe(nil)); end
    def open(io_or_path); end
    def verify_and_open(io_or_path); end
  end
end

class TTFunk::Max < ::TTFunk::Aggregate
  def initialize(init_value = T.unsafe(nil)); end

  def <<(new_value); end
  def value; end
  def value_or(default); end
end

class TTFunk::Min < ::TTFunk::Aggregate
  def initialize(init_value = T.unsafe(nil)); end

  def <<(new_value); end
  def value; end
  def value_or(default); end
end

class TTFunk::OTFEncoder < ::TTFunk::TTFEncoder
  private

  def base_table; end
  def cff_table; end
  def collect_glyphs(glyph_ids); end
  def glyf_table; end
  def loca_table; end
  def optimal_table_order; end
  def tables; end
  def vorg_table; end
end

TTFunk::OTFEncoder::OPTIMAL_TABLE_ORDER = T.let(T.unsafe(nil), Array)

class TTFunk::OneBasedArray
  include ::Enumerable

  def initialize(size = T.unsafe(nil)); end

  def [](idx); end
  def each(&block); end
  def size; end
  def to_ary; end

  private

  def entries; end
end

class TTFunk::Placeholder
  def initialize(name, length: T.unsafe(nil)); end

  def length; end
  def name; end
  def position; end
  def position=(_arg0); end
end

module TTFunk::Reader
  private

  def hexdump(string); end
  def io; end
  def parse_from(position); end
  def read(bytes, format); end
  def read_signed(count); end
  def to_signed(number); end
end

class TTFunk::ResourceFile
  def initialize(io); end

  def [](type, index = T.unsafe(nil)); end
  def map; end
  def resources_for(type); end

  private

  def parse_from(offset); end

  class << self
    def open(path); end
  end
end

class TTFunk::SciForm
  def initialize(significand, exponent = T.unsafe(nil)); end

  def ==(other); end
  def eql?(_arg0); end
  def exponent; end
  def significand; end
  def to_f; end
end

class TTFunk::SubTable
  include ::TTFunk::Reader

  def initialize(file, offset, length = T.unsafe(nil)); end

  def eot?; end
  def file; end
  def length; end
  def read(*args); end
  def table_offset; end
end

class TTFunk::SubTable::EOTError < ::StandardError; end

class TTFunk::Sum < ::TTFunk::Aggregate
  def initialize(init_value = T.unsafe(nil)); end

  def <<(operand); end
  def value; end
  def value_or(_default); end
end

class TTFunk::TTFEncoder
  def initialize(original, subset, options = T.unsafe(nil)); end

  def encode; end
  def options; end
  def original; end
  def subset; end

  private

  def align(data, width); end
  def checksum(data); end
  def cmap_table; end
  def cvt_table; end
  def dsig_table; end
  def fpgm_table; end
  def gasp_table; end
  def glyf_table; end
  def glyphs; end
  def head_table; end
  def hhea_table; end
  def hmtx_table; end
  def kern_table; end
  def loca_table; end
  def maxp_table; end
  def name_table; end
  def new_to_old_glyph; end
  def old_to_new_glyph; end
  def optimal_table_order; end
  def os2_table; end
  def post_table; end
  def prep_table; end
  def raw(data); end
  def tables; end
  def vorg_table; end
end

TTFunk::TTFEncoder::OPTIMAL_TABLE_ORDER = T.let(T.unsafe(nil), Array)

class TTFunk::Table
  include ::TTFunk::Reader

  def initialize(file); end

  def exists?; end
  def file; end
  def length; end
  def offset; end
  def raw; end
  def tag; end

  private

  def parse!; end
end

class TTFunk::Table::Cff < ::TTFunk::Table
  def encode(new_to_old, old_to_new); end
  def global_subr_index; end
  def header; end
  def name_index; end
  def string_index; end
  def tag; end
  def top_index; end

  private

  def parse!; end
end

class TTFunk::Table::Cff::Charset < ::TTFunk::SubTable
  include ::Enumerable

  def initialize(top_dict, file, offset_or_id = T.unsafe(nil), length = T.unsafe(nil)); end

  def [](glyph_id); end
  def count; end
  def each; end
  def encode(mapping); end
  def entries; end
  def format; end
  def length; end
  def offset; end
  def offset_or_id; end
  def top_dict; end

  private

  def element_format(fmt = T.unsafe(nil)); end
  def element_width(fmt = T.unsafe(nil)); end
  def find_string(sid); end
  def format_int(sym = T.unsafe(nil)); end
  def format_sym; end
  def parse!; end
  def sid_for(glyph_id); end

  class << self
    def standard_strings; end
    def strings_for_charset_id(charset_id); end
  end
end

TTFunk::Table::Cff::Charset::ARRAY_FORMAT = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Cff::Charset::DEFAULT_CHARSET_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Cff::Charset::EXPERT_CHARSET_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Cff::Charset::EXPERT_SUBSET_CHARSET_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Cff::Charset::FIRST_GLYPH_STRING = T.let(T.unsafe(nil), String)
TTFunk::Table::Cff::Charset::ISO_ADOBE_CHARSET_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Cff::Charset::RANGE_FORMAT_16 = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Cff::Charset::RANGE_FORMAT_8 = T.let(T.unsafe(nil), Integer)
module TTFunk::Table::Cff::Charsets; end
TTFunk::Table::Cff::Charsets::EXPERT = T.let(T.unsafe(nil), TTFunk::OneBasedArray)
TTFunk::Table::Cff::Charsets::EXPERT_SUBSET = T.let(T.unsafe(nil), TTFunk::OneBasedArray)
TTFunk::Table::Cff::Charsets::ISO_ADOBE = T.let(T.unsafe(nil), TTFunk::OneBasedArray)
TTFunk::Table::Cff::Charsets::STANDARD_STRINGS = T.let(T.unsafe(nil), TTFunk::OneBasedArray)

class TTFunk::Table::Cff::Charstring
  def initialize(glyph_id, top_dict, font_dict, raw); end

  def encode; end
  def glyph; end
  def glyph_id; end
  def path; end
  def raw; end
  def render(x: T.unsafe(nil), y: T.unsafe(nil), font_size: T.unsafe(nil)); end

  private

  def add_contour(x, y); end
  def callgsubr; end
  def callsubr; end
  def cntrmask; end
  def endchar; end
  def flex; end
  def flex1; end
  def flex_select; end
  def hflex; end
  def hflex1; end
  def hhcurveto; end
  def hintmask; end
  def hlineto; end
  def hmoveto; end
  def hstem; end
  def hstemhm; end
  def hvcurveto; end
  def parse!; end
  def rcurveline; end
  def read_bytes(length); end
  def rlinecurve; end
  def rlineto; end
  def rmoveto; end
  def rrcurveto; end
  def shortint; end
  def stem; end
  def vhcurveto; end
  def vlineto; end
  def vmoveto; end
  def vstem; end
  def vstemhm; end
  def vvcurveto; end
end

TTFunk::Table::Cff::Charstring::CODE_MAP = T.let(T.unsafe(nil), Hash)
TTFunk::Table::Cff::Charstring::FLEX_CODE_MAP = T.let(T.unsafe(nil), Hash)

class TTFunk::Table::Cff::CharstringsIndex < ::TTFunk::Table::Cff::Index
  def initialize(top_dict, *remaining_args); end

  def [](index); end
  def encode(mapping); end
  def top_dict; end

  private

  def font_dict_for(index); end
end

class TTFunk::Table::Cff::Dict < ::TTFunk::SubTable
  include ::Enumerable

  def [](operator); end
  def each(&block); end
  def each_pair(&block); end
  def encode; end

  private

  def decode_integer(b_zero); end
  def decode_operand(b_zero); end
  def decode_sci; end
  def decode_wide_operator; end
  def encode_exponent(exp); end
  def encode_float(float); end
  def encode_integer(int); end
  def encode_integer32(int); end
  def encode_operand(operand); end
  def encode_operator(operator); end
  def encode_sci(sci); end
  def encode_significand(sig); end
  def pack_decimal_nibbles(nibbles); end
  def parse!; end
  def valid_exponent?(exponent); end
  def valid_significand?(significand); end
  def validate_sci!(significand, exponent); end
end

class TTFunk::Table::Cff::Dict::InvalidOperandError < ::StandardError; end
TTFunk::Table::Cff::Dict::MAX_OPERANDS = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Cff::Dict::OPERAND_BZERO = T.let(T.unsafe(nil), Array)
TTFunk::Table::Cff::Dict::OPERATOR_BZERO = T.let(T.unsafe(nil), Range)
class TTFunk::Table::Cff::Dict::TooManyOperandsError < ::StandardError; end
TTFunk::Table::Cff::Dict::VALID_SCI_EXPONENT_RE = T.let(T.unsafe(nil), Regexp)
TTFunk::Table::Cff::Dict::VALID_SCI_SIGNIFICAND_RE = T.let(T.unsafe(nil), Regexp)
TTFunk::Table::Cff::Dict::WIDE_OPERATOR_ADJUSTMENT = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Cff::Dict::WIDE_OPERATOR_BZERO = T.let(T.unsafe(nil), Integer)

class TTFunk::Table::Cff::Encoding < ::TTFunk::SubTable
  include ::Enumerable

  def initialize(top_dict, file, offset_or_id = T.unsafe(nil), length = T.unsafe(nil)); end

  def [](glyph_id); end
  def count; end
  def each; end
  def encode(new_to_old, old_to_new); end
  def format; end
  def offset; end
  def offset_or_id; end
  def supplemental?; end
  def top_dict; end

  private

  def code_for(glyph_id); end
  def element_format(fmt = T.unsafe(nil)); end
  def element_width(fmt = T.unsafe(nil)); end
  def encode_supplemental(_new_to_old, old_to_new); end
  def format_int(sym = T.unsafe(nil)); end
  def format_sym; end
  def parse!; end

  class << self
    def codes_for_encoding_id(encoding_id); end
  end
end

TTFunk::Table::Cff::Encoding::DEFAULT_ENCODING_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Cff::Encoding::EXPERT_ENCODING_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Cff::Encoding::STANDARD_ENCODING_ID = T.let(T.unsafe(nil), Integer)
module TTFunk::Table::Cff::Encodings; end
TTFunk::Table::Cff::Encodings::EXPERT = T.let(T.unsafe(nil), TTFunk::OneBasedArray)
TTFunk::Table::Cff::Encodings::STANDARD = T.let(T.unsafe(nil), TTFunk::OneBasedArray)

class TTFunk::Table::Cff::FdSelector < ::TTFunk::SubTable
  include ::Enumerable

  def initialize(top_dict, file, offset, length = T.unsafe(nil)); end

  def [](glyph_id); end
  def count; end
  def each; end
  def encode(mapping); end
  def entries; end
  def n_glyphs; end
  def top_dict; end

  private

  def format_sym; end
  def parse!; end
  def range_cache; end
  def rangify_gids(values); end
end

TTFunk::Table::Cff::FdSelector::ARRAY_ENTRY_SIZE = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Cff::FdSelector::ARRAY_FORMAT = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Cff::FdSelector::RANGE_ENTRY_SIZE = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Cff::FdSelector::RANGE_FORMAT = T.let(T.unsafe(nil), Integer)

class TTFunk::Table::Cff::FontDict < ::TTFunk::Table::Cff::Dict
  def initialize(top_dict, file, offset, length = T.unsafe(nil)); end

  def encode(_mapping); end
  def finalize(new_cff_data, mapping); end
  def private_dict; end
  def top_dict; end

  private

  def encode_private; end
end

TTFunk::Table::Cff::FontDict::OPERATORS = T.let(T.unsafe(nil), Hash)
TTFunk::Table::Cff::FontDict::OPERATOR_CODES = T.let(T.unsafe(nil), Hash)
TTFunk::Table::Cff::FontDict::PLACEHOLDER_LENGTH = T.let(T.unsafe(nil), Integer)

class TTFunk::Table::Cff::FontIndex < ::TTFunk::Table::Cff::Index
  def initialize(top_dict, file, offset, length = T.unsafe(nil)); end

  def [](index); end
  def finalize(new_cff_data, mapping); end
  def top_dict; end
end

class TTFunk::Table::Cff::Header < ::TTFunk::SubTable
  def absolute_offset_size; end
  def encode; end
  def header_size; end
  def length; end
  def major; end
  def minor; end

  private

  def parse!; end
end

class TTFunk::Table::Cff::Index < ::TTFunk::SubTable
  include ::Enumerable

  def [](index); end
  def count; end
  def data_start_pos; end
  def each; end
  def encode; end
  def offset_size; end
  def offsets; end
  def raw_data; end
  def raw_offset_length; end

  private

  def absolute_offsets_for(index); end
  def encode_offset(offset, offset_size); end
  def entry_cache; end
  def parse!; end
  def unpack_offset(offset_data); end
end

class TTFunk::Table::Cff::OneBasedIndex
  extend ::Forwardable

  def initialize(*args); end

  def [](idx); end
  def base_index; end
  def count(*args, &block); end
  def each(*args, &block); end
  def encode(*args, &block); end
  def length(*args, &block); end
  def table_offset(*args, &block); end
end

class TTFunk::Table::Cff::Path
  def initialize; end

  def close_path; end
  def commands; end
  def curve_to(x1, y1, x2, y2, x, y); end
  def line_to(x, y); end
  def move_to(x, y); end
  def number_of_contours; end
  def render(x: T.unsafe(nil), y: T.unsafe(nil), font_size: T.unsafe(nil), units_per_em: T.unsafe(nil)); end

  private

  def format_values(command); end
end

TTFunk::Table::Cff::Path::CLOSE_PATH_CMD = T.let(T.unsafe(nil), Array)

class TTFunk::Table::Cff::PrivateDict < ::TTFunk::Table::Cff::Dict
  def default_width_x; end
  def encode(_mapping); end
  def finalize(private_dict_data); end
  def nominal_width_x; end
  def subr_index; end

  private

  def encode_subrs; end
end

TTFunk::Table::Cff::PrivateDict::DEFAULT_WIDTH_X_DEFAULT = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Cff::PrivateDict::DEFAULT_WIDTH_X_NOMINAL = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Cff::PrivateDict::OPERATORS = T.let(T.unsafe(nil), Hash)
TTFunk::Table::Cff::PrivateDict::OPERATOR_CODES = T.let(T.unsafe(nil), Hash)
TTFunk::Table::Cff::PrivateDict::PLACEHOLDER_LENGTH = T.let(T.unsafe(nil), Integer)

class TTFunk::Table::Cff::SubrIndex < ::TTFunk::Table::Cff::Index
  def bias; end
end

TTFunk::Table::Cff::TAG = T.let(T.unsafe(nil), String)

class TTFunk::Table::Cff::TopDict < ::TTFunk::Table::Cff::Dict
  def cff; end
  def cff_offset; end
  def charset; end
  def charstring_type; end
  def charstrings_index; end
  def encode(*_arg0); end
  def encoding; end
  def finalize(new_cff_data, new_to_old, old_to_new); end
  def font_dict_selector; end
  def font_index; end
  def is_cid_font?; end
  def private_dict; end
  def ros; end
  def ros?; end

  private

  def encode_charstring_type(charstring_type); end
  def encode_private; end
  def finalize_subtable(new_cff_data, name, table_data); end
  def pointer_operator?(operator); end
end

TTFunk::Table::Cff::TopDict::DEFAULT_CHARSTRING_TYPE = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Cff::TopDict::OPERATORS = T.let(T.unsafe(nil), Hash)
TTFunk::Table::Cff::TopDict::OPERATOR_CODES = T.let(T.unsafe(nil), Hash)
TTFunk::Table::Cff::TopDict::PLACEHOLDER_LENGTH = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Cff::TopDict::POINTER_OPERATORS = T.let(T.unsafe(nil), Hash)
TTFunk::Table::Cff::TopDict::POINTER_PLACEHOLDER_LENGTH = T.let(T.unsafe(nil), Integer)

class TTFunk::Table::Cff::TopIndex < ::TTFunk::Table::Cff::Index
  def [](index); end
end

class TTFunk::Table::Cmap < ::TTFunk::Table
  def tables; end
  def unicode; end
  def version; end

  private

  def parse!; end

  class << self
    def encode(charmap, encoding); end
  end
end

module TTFunk::Table::Cmap::Format00
  def [](code); end
  def code_map; end
  def language; end
  def supported?; end

  private

  def parse_cmap!; end

  class << self
    def encode(charmap); end
  end
end

module TTFunk::Table::Cmap::Format04
  def [](code); end
  def code_map; end
  def language; end
  def supported?; end

  private

  def parse_cmap!; end

  class << self
    def encode(charmap); end
  end
end

module TTFunk::Table::Cmap::Format06
  def [](code); end
  def code_map; end
  def language; end
  def supported?; end

  private

  def parse_cmap!; end

  class << self
    def encode(charmap); end
  end
end

module TTFunk::Table::Cmap::Format10
  def [](code); end
  def code_map; end
  def language; end
  def supported?; end

  private

  def parse_cmap!; end

  class << self
    def encode(charmap); end
  end
end

module TTFunk::Table::Cmap::Format12
  def [](code); end
  def code_map; end
  def language; end
  def supported?; end

  private

  def parse_cmap!; end

  class << self
    def encode(charmap); end
  end
end

class TTFunk::Table::Cmap::Subtable
  include ::TTFunk::Reader

  def initialize(file, table_start); end

  def [](_code); end
  def encoding_id; end
  def format; end
  def platform_id; end
  def supported?; end
  def unicode?; end

  private

  def parse_cmap!; end

  class << self
    def encode(charmap, encoding); end
  end
end

TTFunk::Table::Cmap::Subtable::ENCODING_MAPPINGS = T.let(T.unsafe(nil), Hash)

class TTFunk::Table::Dsig < ::TTFunk::Table
  def flags; end
  def signatures; end
  def tag; end
  def version; end

  private

  def parse!; end

  class << self
    def encode(dsig); end
  end
end

class TTFunk::Table::Dsig::SignatureRecord
  def initialize(format, length, offset, signature); end

  def format; end
  def length; end
  def offset; end
  def signature; end
end

TTFunk::Table::Dsig::TAG = T.let(T.unsafe(nil), String)

class TTFunk::Table::Glyf < ::TTFunk::Table
  def for(glyph_id); end

  private

  def parse!; end

  class << self
    def encode(glyphs, new_to_old, old_to_new); end
  end
end

class TTFunk::Table::Glyf::Compound
  include ::TTFunk::Reader

  def initialize(id, raw); end

  def compound?; end
  def glyph_ids; end
  def id; end
  def number_of_contours; end
  def raw; end
  def recode(mapping); end
  def x_max; end
  def x_min; end
  def y_max; end
  def y_min; end
end

TTFunk::Table::Glyf::Compound::ARG_1_AND_2_ARE_WORDS = T.let(T.unsafe(nil), Integer)

class TTFunk::Table::Glyf::Compound::Component < ::Struct
  def arg1; end
  def arg1=(_); end
  def arg2; end
  def arg2=(_); end
  def flags; end
  def flags=(_); end
  def glyph_index; end
  def glyph_index=(_); end
  def transform; end
  def transform=(_); end

  class << self
    def [](*_arg0); end
    def inspect; end
    def members; end
    def new(*_arg0); end
  end
end

TTFunk::Table::Glyf::Compound::MORE_COMPONENTS = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Glyf::Compound::WE_HAVE_AN_X_AND_Y_SCALE = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Glyf::Compound::WE_HAVE_A_SCALE = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Glyf::Compound::WE_HAVE_A_TWO_BY_TWO = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Glyf::Compound::WE_HAVE_INSTRUCTIONS = T.let(T.unsafe(nil), Integer)

class TTFunk::Table::Glyf::PathBased
  def initialize(path, horizontal_metrics); end

  def compound?; end
  def horizontal_metrics; end
  def left_side_bearing; end
  def number_of_contours; end
  def path; end
  def right_side_bearing; end
  def x_max; end
  def x_min; end
  def y_max; end
  def y_min; end
end

class TTFunk::Table::Glyf::Simple
  def initialize(id, raw); end

  def compound?; end
  def end_point_of_last_contour; end
  def end_points_of_contours; end
  def id; end
  def instruction_length; end
  def instructions; end
  def number_of_contours; end
  def raw; end
  def recode(_mapping); end
  def x_max; end
  def x_min; end
  def y_max; end
  def y_min; end
end

class TTFunk::Table::Head < ::TTFunk::Table
  def checksum_adjustment; end
  def created; end
  def flags; end
  def font_direction_hint; end
  def font_revision; end
  def glyph_data_format; end
  def index_to_loc_format; end
  def lowest_rec_ppem; end
  def mac_style; end
  def magic_number; end
  def modified; end
  def units_per_em; end
  def version; end
  def x_max; end
  def x_min; end
  def y_max; end
  def y_min; end

  private

  def parse!; end

  class << self
    def encode(head, loca, mapping); end

    private

    def min_max_values_for(head, mapping); end
  end
end

class TTFunk::Table::Hhea < ::TTFunk::Table
  def advance_width_max; end
  def ascent; end
  def caret_offset; end
  def carot_slope_rise; end
  def carot_slope_run; end
  def descent; end
  def line_gap; end
  def metric_data_format; end
  def min_left_side_bearing; end
  def min_right_side_bearing; end
  def number_of_metrics; end
  def version; end
  def x_max_extent; end

  private

  def parse!; end

  class << self
    def encode(hhea, hmtx, original, mapping); end

    private

    def min_max_values_for(original, mapping); end
  end
end

class TTFunk::Table::Hmtx < ::TTFunk::Table
  def for(glyph_id); end
  def left_side_bearings; end
  def metrics; end
  def widths; end

  private

  def metrics_cache; end
  def parse!; end

  class << self
    def encode(hmtx, mapping); end
  end
end

class TTFunk::Table::Hmtx::HorizontalMetric < ::Struct
  def advance_width; end
  def advance_width=(_); end
  def left_side_bearing; end
  def left_side_bearing=(_); end

  class << self
    def [](*_arg0); end
    def inspect; end
    def members; end
    def new(*_arg0); end
  end
end

class TTFunk::Table::Kern < ::TTFunk::Table
  def tables; end
  def version; end

  private

  def add_table(format, attributes = T.unsafe(nil)); end
  def parse!; end
  def parse_version_0_tables(_num_tables); end
  def parse_version_1_tables(num_tables); end

  class << self
    def encode(kerning, mapping); end
  end
end

class TTFunk::Table::Kern::Format0
  include ::TTFunk::Reader

  def initialize(attributes = T.unsafe(nil)); end

  def attributes; end
  def cross_stream?; end
  def horizontal?; end
  def pairs; end
  def recode(mapping); end
  def vertical?; end
end

class TTFunk::Table::Loca < ::TTFunk::Table
  def index_of(glyph_id); end
  def offsets; end
  def size_of(glyph_id); end

  private

  def parse!; end

  class << self
    def encode(offsets); end
  end
end

class TTFunk::Table::Maxp < ::TTFunk::Table
  def max_component_contours; end
  def max_component_depth; end
  def max_component_elements; end
  def max_component_points; end
  def max_contours; end
  def max_function_defs; end
  def max_instruction_defs; end
  def max_points; end
  def max_size_of_instructions; end
  def max_stack_elements; end
  def max_storage; end
  def max_twilight_points; end
  def max_zones; end
  def num_glyphs; end
  def version; end

  private

  def parse!; end

  class << self
    def encode(maxp, mapping); end
  end
end

class TTFunk::Table::Name < ::TTFunk::Table
  def compatible_full; end
  def copyright; end
  def description; end
  def designer; end
  def designer_url; end
  def entries; end
  def font_family; end
  def font_name; end
  def font_subfamily; end
  def license; end
  def license_url; end
  def manufacturer; end
  def postscript_name; end
  def preferred_family; end
  def preferred_subfamily; end
  def sample_text; end
  def strings; end
  def trademark; end
  def unique_subfamily; end
  def vendor_url; end
  def version; end

  private

  def parse!; end

  class << self
    def encode(names, key = T.unsafe(nil)); end
  end
end

TTFunk::Table::Name::COMPATIBLE_FULL_NAME_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Name::COPYRIGHT_NAME_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Name::DESCRIPTION_NAME_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Name::DESIGNER_NAME_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Name::DESIGNER_URL_NAME_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Name::FONT_FAMILY_NAME_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Name::FONT_NAME_NAME_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Name::FONT_SUBFAMILY_NAME_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Name::LICENSE_NAME_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Name::LICENSE_URL_NAME_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Name::MANUFACTURER_NAME_ID = T.let(T.unsafe(nil), Integer)

class TTFunk::Table::Name::NameString < ::String
  def initialize(text, platform_id, encoding_id, language_id); end

  def encoding_id; end
  def language_id; end
  def platform_id; end
  def strip_extended; end
end

TTFunk::Table::Name::POSTSCRIPT_NAME_NAME_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Name::PREFERRED_FAMILY_NAME_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Name::PREFERRED_SUBFAMILY_NAME_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Name::SAMPLE_TEXT_NAME_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Name::TRADEMARK_NAME_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Name::UNIQUE_SUBFAMILY_NAME_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Name::VENDOR_URL_NAME_ID = T.let(T.unsafe(nil), Integer)
TTFunk::Table::Name::VERSION_NAME_ID = T.let(T.unsafe(nil), Integer)

class TTFunk::Table::OS2 < ::TTFunk::Table
  def ascent; end
  def ave_char_width; end
  def break_char; end
  def cap_height; end
  def char_range; end
  def code_page_range; end
  def default_char; end
  def descent; end
  def family_class; end
  def first_char_index; end
  def last_char_index; end
  def line_gap; end
  def max_context; end
  def panose; end
  def selection; end
  def tag; end
  def type; end
  def vendor_id; end
  def version; end
  def weight_class; end
  def width_class; end
  def win_ascent; end
  def win_descent; end
  def x_height; end
  def y_strikeout_position; end
  def y_strikeout_size; end
  def y_subscript_x_offset; end
  def y_subscript_x_size; end
  def y_subscript_y_offset; end
  def y_subscript_y_size; end
  def y_superscript_x_offset; end
  def y_superscript_x_size; end
  def y_superscript_y_offset; end
  def y_superscript_y_size; end

  private

  def parse!; end

  class << self
    def encode(os2, subset); end

    private

    def avg_char_width_for(os2, subset); end
    def avg_ms_symbol_char_width_for(os2, subset); end
    def avg_weighted_char_width_for(os2, subset); end
    def code_pages_for(subset); end
    def group_original_code_points_by_bit(os2); end
    def unicode_blocks_for(os2, original_field, subset); end
  end
end

TTFunk::Table::OS2::CODEPOINT_SPACE = T.let(T.unsafe(nil), Integer)
TTFunk::Table::OS2::CODE_PAGE_BITS = T.let(T.unsafe(nil), Hash)
TTFunk::Table::OS2::LOWERCASE_COUNT = T.let(T.unsafe(nil), Integer)
TTFunk::Table::OS2::LOWERCASE_END = T.let(T.unsafe(nil), Integer)
TTFunk::Table::OS2::LOWERCASE_START = T.let(T.unsafe(nil), Integer)
TTFunk::Table::OS2::SPACE_GLYPH_MISSING_ERROR = T.let(T.unsafe(nil), String)
TTFunk::Table::OS2::UNICODE_BLOCKS = T.let(T.unsafe(nil), Hash)
TTFunk::Table::OS2::UNICODE_MAX = T.let(T.unsafe(nil), Integer)
TTFunk::Table::OS2::UNICODE_RANGES = T.let(T.unsafe(nil), Array)
TTFunk::Table::OS2::WEIGHT_LOWERCASE = T.let(T.unsafe(nil), Array)
TTFunk::Table::OS2::WEIGHT_SPACE = T.let(T.unsafe(nil), Integer)

class TTFunk::Table::Post < ::TTFunk::Table
  def fixed_pitch; end
  def fixed_pitch?; end
  def format; end
  def glyph_for(_code); end
  def italic_angle; end
  def max_mem_type1; end
  def max_mem_type42; end
  def min_mem_type1; end
  def min_mem_type42; end
  def recode(mapping); end
  def subtable; end
  def underline_position; end
  def underline_thickness; end

  private

  def parse!; end
  def parse_format!; end

  class << self
    def encode(post, mapping); end
  end
end

module TTFunk::Table::Post::Format10
  def glyph_for(code); end

  private

  def parse_format!; end
end

TTFunk::Table::Post::Format10::POSTSCRIPT_GLYPHS = T.let(T.unsafe(nil), Array)

module TTFunk::Table::Post::Format20
  include ::TTFunk::Table::Post::Format10

  def glyph_for(code); end

  private

  def parse_format!; end
end

module TTFunk::Table::Post::Format30
  def glyph_for(_code); end

  private

  def parse_format!; end
end

module TTFunk::Table::Post::Format40
  def glyph_for(code); end

  private

  def parse_format!; end
end

class TTFunk::Table::Sbix < ::TTFunk::Table
  def all_bitmap_data_for(glyph_id); end
  def bitmap_data_for(glyph_id, strike_index); end
  def flags; end
  def num_strikes; end
  def strikes; end
  def version; end

  private

  def parse!; end
end

class TTFunk::Table::Sbix::BitmapData < ::Struct
  def data; end
  def data=(_); end
  def ppem; end
  def ppem=(_); end
  def resolution; end
  def resolution=(_); end
  def type; end
  def type=(_); end
  def x; end
  def x=(_); end
  def y; end
  def y=(_); end

  class << self
    def [](*_arg0); end
    def inspect; end
    def members; end
    def new(*_arg0); end
  end
end

class TTFunk::Table::Vorg < ::TTFunk::Table
  def count; end
  def default_vert_origin_y; end
  def for(glyph_id); end
  def major_version; end
  def minor_version; end
  def origins; end
  def tag; end

  private

  def parse!; end

  class << self
    def encode(vorg); end
  end
end

TTFunk::Table::Vorg::TAG = T.let(T.unsafe(nil), String)
class TTFunk::UnresolvedPlaceholderError < ::StandardError; end
