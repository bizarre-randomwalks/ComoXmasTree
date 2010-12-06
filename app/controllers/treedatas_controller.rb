require "rexml/document"
include REXML
class TreedatasController < ApplicationController
  def index
    @treedata = Treedata.last
    
    @treexml = generateXML(@treedata.branch)
    respond_to do |format|
      format.xml {render :xml => @treexml }
    end
  end

  private

  def generateXML(root)
    string = "<tree></tree>"

    doc = Document.new string
    rootElem = Element.new "branch" 
    rootElem.add_attribute('id', root.id)
    rootElem.add_attribute('length', root.length)
    rootElem.add_attribute('scale', root.scale)
    rootElem.add_attribute('rotation', root.rotation)
    rootElem.add_attribute('y', root.y)

    recursiveGenerateXML(root, rootElem)

    doc.root.add(rootElem)
    return doc
  end

  def recursiveGenerateXML(data, elem)
    if data.has_children?
      data.children.each do |children|
        childElem = Element.new "branch"
        childElem.add_attribute('id', children.id)
        childElem.add_attribute('length', children.length)
        childElem.add_attribute('scale', children.scale)
        childElem.add_attribute('rotation', children.rotation)
        childElem.add_attribute('y', children.y)
        begin
          childElem.add_attribute("tweet_title", children.tweet.title)
          childElem.add_attribute("screen_name", children.tweet.screen_name)
        rescue
        end

        
        elem.add(childElem)
        recursiveGenerateXML(children, childElem)
      end
    end
  end

end
